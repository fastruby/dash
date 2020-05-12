class Issue < ApplicationRecord
  has_many :issues_assignees
  has_many :assignees, through: :issues_assignees, class_name: "User", source: :user

  def self.create_or_update_issue(issue)
    if issue["pull_request"].nil?
      _issue = Issue.find_or_create_by(issue_link: issue.html_url)
      _issue.update(title: issue.title,
                    issue_number: issue.number,
                    issue_link: issue.html_url,
                    repository_link: _issue.repo_url(issue),
                    state: issue.state,
                    repository_name: _issue.repo_name(issue))

      _issue.issue_assignees(issue.assignees)
    end
  end

  def issue_assignees(_assignees)
    self.assignees = []

    _assignees.each do | assignee |
      user = User.find_by_name(assignee["login"])
      IssuesAssignee.find_or_create_by(user_id: user.id, issue_id: self.id) if user
    end
  end

  def self.remove_closed_issues(_issues)
    github_issues_links = _issues.map {|x| x.html_url }
    Issue.where.not(issue_link: github_issues_links).delete_all
  end

  def repo_url(pr)
    "https://github.com/#{repo_name(pr)}"
  end

  def repo_name(issue)
    issue.html_url.split("/")[-4..-3].join("/")
  end
end
