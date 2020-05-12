class CreatePullRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :pull_requests do |t|
      t.string :title
      t.integer :pull_request_number
      t.string :pull_request_link
      t.string :repository_link
      t.string :state
      t.string :repository_name

      t.timestamps
    end
  end
end
