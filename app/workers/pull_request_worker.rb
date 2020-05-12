class PullRequestWorker
  include Sidekiq::Worker

  def perform(access_token)
    client = Octokit::Client.new(access_token: access_token)

    orgs_repositories = ORGANIZATIONS.map do |org_name|
      get_repositories(org_name, client)
    end.flatten

    pull_requests = get_pull_requests(orgs_repositories, client)

    PullRequest.remove_closed_pull_requests(pull_requests)

    pull_requests.each do |pull_request|
      PullRequest.create_or_update_pull_request(pull_request)
    end
  end

  private

    def get_repositories(org_name, client)
      client.org_repos(org_name)
    end

    def get_pull_requests(orgs_repositories, client)
      orgs_repositories.flat_map do |repository|
        client.pull_requests(repository.full_name, state: 'open')
      end
    end
end
