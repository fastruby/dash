class PivotalWorker
  include Sidekiq::Worker
  sidekiq_options retry: 1

  def perform(user_id)
    user = User.find(user_id)

    pivotal_service = PivotalApiService.new(user.pivotal_token)

    @first_run = user.pivotal_id.nil?
    user.update(pivotal_id: pivotal_service.user_pivotal_id) unless user.pivotal_id

    pivotal_service.update_stories
  end
end
