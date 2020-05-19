class OctokitService
  attr_accessor :client

  def initialize(access_token)
    @client = Octokit::Client.new(:access_token => access_token)
  end

  def get_repositories(org_name)
    client.org_repos(org_name,  per_page: 200)
  end

  def get_issues(repositories)
    repositories.flatten.flat_map do |r|
      client.list_issues(r.full_name)
    end
  end

  def get_issue(issue)
   client.issue(issue.repository_name, issue.issue_number)
  end

  def get_pull_requests(repositories)
    repositories.flatten.flat_map do |r|
      client.pull_requests(r.full_name, :state => 'open')
    end
  end

  def get_pull_request(pull_request)
    client.pull_request(pull_request.repository_name, pull_request.pull_request_number)
  end
end
