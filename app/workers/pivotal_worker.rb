class PivotalWorker
include Sidekiq::Worker
sidekiq_options retry: 1

  def perform(user_id)
    user = User.find(user_id)

    @client = TrackerApi::Client.new(token: user.pivotal_token)

    @first_run = user.pivotal_id.nil?
    user.update(pivotal_id: @client.me.id) unless user.pivotal_id

    stories = get_stories(@client.projects)

    stories.each do |story|
      if story.current_state != "accepted"
        project_id = story[:project_id]
        project_name = get_project_name(project_id)
        PivotalStory.create_update_pivotal_story(story, project_name)
      else
        PivotalStory.find_by(story_number: story.id)&.destroy
      end
    end
  end

private

  def filter
    @filter ||= PIVOTAL_STATES.map { |st| "state:#{st}"}.join(" OR ")
  end

  def get_stories(projects)
    projects.map do |project|
      _project = PivotalProject.find_or_create_by(pivotal_id: project.id)
      if @first_run || _project.version != project.version
        _project.update_column :version, project.version
        project.stories(filter: filter)
      else
        []
      end
    end.flatten
  end

  def get_project_name(project_id)
    @client.project(project_id).name
  end
end
