class PivotalApiService
  attr_accessor :client

  def initialize(user_pivotal_token)
    @client = TrackerApi::Client.new(token: user_pivotal_token)
  end

  def update_stories
    stories = get_stories
    stories.each do |story|
      if story.current_state == "accepted"
        PivotalStory.find_by(story_number: story.id)&.destroy
      else
        project_id = story[:project_id]
        project_name = get_project_name(project_id)
        PivotalStory.create_update_pivotal_story(story, project_name)
      end
    end
  end

  def user_pivotal_id
    client.me.id
  end

  private
    def get_stories
      projects = get_projects
      projects.map do |project|
        _project = PivotalProject.find_or_create_by(pivotal_id: project.id)
        if _project.version != project.version
          _project.update_column :version, project.version
          project.stories(filter: filter)
        else
          []
        end
      end.flatten
    end

    def get_projects
      client.projects
    end

    def get_project_name(project_id)
      client.project(project_id).name
    end

    def filter
      @filter ||= PIVOTAL_STATES.map { |st| "state:#{st}"}.join(" OR ")
    end
end
