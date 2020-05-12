class CreatePullRequestsAssignees < ActiveRecord::Migration[6.0]
  def change
    create_table :pull_requests_assignees do |t|
      t.references :user, null: false, foreign_key: true
      t.references :pull_request, null: false, foreign_key: true
    end
  end
end
