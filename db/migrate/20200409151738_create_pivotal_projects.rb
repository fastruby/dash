class CreatePivotalProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :pivotal_projects do |t|
      t.integer :pivotal_id
      t.integer :version
      t.timestamps
    end
    add_index(:pivotal_projects, :pivotal_id, unique: true)
  end
end
