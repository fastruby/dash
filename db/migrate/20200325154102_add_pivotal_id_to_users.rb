class AddPivotalIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :pivotal_id, :string
  end
end
