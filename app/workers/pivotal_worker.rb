class PivotalWorker
  include Sidekiq::Worker
  sidekiq_options retry: 1

  def perform(user_id)
    user = User.find(user_id)

    @client = TrackerApi::Client.new(token: user.pivotal_token)

    @first_run = user.pivotal_id.nil?
    user.update(pivotal_id: @client.me.id) unless user.pivotal_id

    @client.projects.map do |project|
      _project = PivotalProject.find_or_create_by(pivotal_id: project.id)
      _project.sync_with(project, force: @first_run)
    end
  end
end
