class AddCascadeToForeignKeysIssuesAssignees < ActiveRecord::Migration[6.0]
  def up
    remove_foreign_key :issues_assignees, :issues
    add_foreign_key :issues_assignees, :issues, on_delete: :cascade
  end

  def down
    remove_foreign_key :issues_assignees, :issues
    add_foreign_key :issues_assignees, :issues
  end
end
