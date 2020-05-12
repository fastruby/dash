class AddCascadingToForeignKeys < ActiveRecord::Migration[6.0]
  def up
    remove_foreign_key :pull_requests_assignees, :pull_requests
    add_foreign_key :pull_requests_assignees, :pull_requests, on_delete: :cascade
  end

  def down
    remove_foreign_key :pull_requests_assignees, :pull_requests
    add_foreign_key :pull_requests_assignees, :pull_requests
  end
end
