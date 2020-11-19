class AddAuthorToPullRequest < ActiveRecord::Migration[6.0]
  def change
    add_column :pull_requests, :author_name, :string
    add_column :pull_requests, :author_id, :integer
    add_index :pull_requests, :author_id
  end
end
