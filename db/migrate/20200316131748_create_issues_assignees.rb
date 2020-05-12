class CreateIssuesAssignees < ActiveRecord::Migration[6.0]
  def change
    create_table :issues_assignees do |t|
      t.references :user, null: false, foreign_key: true
      t.references :issue, null: false, foreign_key: true

      t.timestamps
    end
  end
end
