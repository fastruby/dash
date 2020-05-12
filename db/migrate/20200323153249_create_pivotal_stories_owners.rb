class CreatePivotalStoriesOwners < ActiveRecord::Migration[6.0]
  def change
    create_table :pivotal_stories_owners do |t|
      t.references :user, null: false, foreign_key: true
      t.references :pivotal_story, null: false, foreign_key: true

      t.timestamps
    end
  end
end
