class AddAuthorToIssues < ActiveRecord::Migration[6.1]
  def change
    add_column :issues, :author_name, :string
    add_column :issues, :author_id, :integer
    add_index :issues, :author_id
  end
end
