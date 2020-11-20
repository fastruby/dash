class PullRequest < ApplicationRecord
  has_many :pull_requests_assignees
  has_many :assignees, through: :pull_requests_assignees, class_name: "User", source: :user

  has_many :pull_requests_reviewers
  has_many :reviewers, through: :pull_requests_reviewers, class_name: "User", source: :user

  def self.create_or_update_pull_request(pr)
    pull = PullRequest.find_or_create_by(pull_request_link: pr.html_url)
    pull.update(
        title: pr.title,
        pull_request_number: pr.number,
        repository_link: pull.repo_url(pr),
        state: pr.state,
        repository_name: self.repo_name(pr),
        author: pr.user.login
      )

    pull.pr_assignees(pr.assignees)
    pull.pr_reviewers(pr.requested_reviewers)
  end

  def create_or_update_from_webhook(response)
    if WEBHOOK_ACTIONS.include?(response["action"])
      pull = PullRequest.find_or_create_by(pull_request_link: response["pull_request"]["html_url"])
      pull.update(
        title: response["pull_request"]["title"],
        pull_request_number: response["pull_request"]["number"],
        repository_link: response["pull_request"]["head"]["repo"]["html_url"],
        state: response["pull_request"]["state"]
      )

        pull.pr_assignees(response["pull_request"]["assignees"])
        pull.pr_reviewers(response["pull_request"]["requested_reviewers"])
    end
  end

  def self.sync_with_github
    pull_requests = self.where(state: :open)
    octokit_service = OctokitService.new(ENV["GITHUB_MACHINE_USER_ACCESS_TOKEN"])

    pull_requests.each do |pull_request|
      begin
        updated_pull_request = octokit_service.get_pull_request(pull_request)
        pull_request.updates_pr(updated_pull_request)
      rescue Octokit::NotFound
        self.remove_closed_pull_request(pull_request)
      end
    end
  end

  def pr_assignees(_assignees)
    self.assignees = []
    _assignees.each do | assignee |
      user = User.find_by_name(assignee["login"])
      PullRequestsAssignee.find_or_create_by(user_id: user.id, pull_request_id: self.id) if user
    end
  end

  def pr_reviewers(_reviewers)
    self.reviewers = []

    _reviewers.each do | reviewer |
      user = User.find_by_name(reviewer["login"])
      PullRequestsReviewer.find_or_create_by(user_id: user.id, pull_request_id: self.id) if user
    end
  end

  def self.remove_closed_pull_requests(_pull_requests)
    github_pull_request_links = _pull_requests.map {|x| x.html_url }
    PullRequest.where.not(pull_request_link: github_pull_request_links).delete_all
  end

  def self.remove_closed_pull_request(_pull_request)
    PullRequest.find(_pull_request.id).delete
  end

  def updates_pr(updated_pr)
    update(state: updated_pr["state"])

    pr_assignees(updated_pr["assignees"])
    pr_reviewers(updated_pr["requested_reviewers"])
  end

  def repo_url(pr)
    "https://github.com/#{repo_name(pr)}"
  end

  def repo_name(pr)
    pr.html_url.split("/")[-4..-3].join("/")
  end

  def self.repo_name(pr)
    pr.html_url.split("/")[-4..-3].join("/")
  end
end
