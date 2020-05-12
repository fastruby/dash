class CreateIssues < ActiveRecord::Migration[6.0]
  def change
    create_table :issues do |t|
      t.string :title
      t.integer :issue_number
      t.string :issue_link
      t.string :repository_link
      t.string :state
      t.string :repository_name

      t.timestamps
    end
  end
end
