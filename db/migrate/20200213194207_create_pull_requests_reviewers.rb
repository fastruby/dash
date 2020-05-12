class CreatePullRequestsReviewers < ActiveRecord::Migration[6.0]
  def change
    create_table :pull_requests_reviewers do |t|
      t.references :user
      t.references :pull_request
    end
  end
end
