class AddCascadingToForeignKeysPullRequestsReviewers < ActiveRecord::Migration[6.0]
  def up
    add_foreign_key :pull_requests_reviewers, :pull_requests, on_delete: :cascade
  end

  def down
    remove_foreign_key :pull_requests_reviewers, :pull_requests
    add_foreign_key :pull_requests_reviewers, :pull_requests
  end
end
