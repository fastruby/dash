class IssueWorker
  include Sidekiq::Worker

  def perform(access_token)
    client = Octokit::Client.new(access_token: access_token)

    orgs_repositories = ORGANIZATIONS.map do |org_name|
      get_repositories(org_name, client)
    end.flatten

    issues = get_issues(orgs_repositories, client)
    Issue.remove_closed_issues(issues)

    issues.each do |issue|
      Issue.create_or_update_issue(issue)
    end
  end

  private

    def get_repositories(org_name, client)
      client.org_repos(org_name)
    end

    def get_issues(orgs_repositories, client)
      orgs_repositories.flat_map do |repository|
        client.list_issues(repository.full_name)
      end
    end
end
