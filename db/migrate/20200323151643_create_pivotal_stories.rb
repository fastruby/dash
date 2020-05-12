class CreatePivotalStories < ActiveRecord::Migration[6.0]
  def change
    create_table :pivotal_stories do |t|
      t.string :name
      t.integer :story_number
      t.string :story_link
      t.string :project_link
      t.string :project_name
      t.string :state

      t.timestamps
    end
  end
end
