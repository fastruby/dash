class AddAuthorToPullRequest < ActiveRecord::Migration[6.0]
  def change
    add_column :pull_requests, :author, :string
  end
end
