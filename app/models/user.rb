class User < ApplicationRecord
  has_many :pull_requests_assignees
  has_many :pull_requests, through: :pull_requests_assignees

  has_many :pull_requests_reviewers
  has_many :prs, through: :pull_requests_reviewers, class_name: "PullRequest", source: :pull_request

  has_many :issues_assignees
  has_many :issues, through: :issues_assignees

  has_many :pivotal_stories_owners
  has_many :pivotal_stories, through: :pivotal_stories_owners
  has_many :owned_pull_requests, foreign_key: "author_id", class_name: "PullRequest"

  lockbox_encrypts :pivotal_token

  validates :pivotal_token, length: { is: 32 },
                            allow_blank: true,
                            allow_nil: true,
                            on: :update


  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["nickname"]
    end
  end

  def my_pulls
    (pull_requests + prs + owned_pull_requests).uniq
  end
end
