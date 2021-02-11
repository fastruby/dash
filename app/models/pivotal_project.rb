class PivotalProject < ApplicationRecord
  validates :pivotal_id, presence: true, uniqueness: true

  def sync_with(project, force: false)
    if force || version != project.version
      update_version(project.version)
      update_stories(filtered_stories(project), project.name) # TODO: refactor this
    end
  end

  private
  
    def filtered_stories(project)
      project.stories(filter: filter)
    end

    def update_version(version)
      update_column :version, version
    end

    def update_stories(stories, project_name)
      stories.each do |story|
        if story.current_state == "accepted"
          PivotalStory.find_by(story_number: story.id)&.destroy
        else
          PivotalStory.create_update_pivotal_story(story, project_name)
        end
      end
      delete_stories_not_in_list(stories, project_name)
    end

    def delete_stories_not_in_list(_stories, project_name)
      story_request_links = _stories.map {|story| story[:url] }
      stories = PivotalStory.where(project_name: project_name)
      stories.where.not(story_link: story_request_links).delete_all
    end

    def filter
      @filter ||= PIVOTAL_STATES.map { |st| "state:#{st}"}.join(" OR ")
    end
end
