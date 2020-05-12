class AddCascadingToForeignKeysPivotalStoriesOwner < ActiveRecord::Migration[6.0]
  def up
    remove_foreign_key :pivotal_stories_owners, :pivotal_stories
    add_foreign_key :pivotal_stories_owners, :pivotal_stories, on_delete: :cascade
  end

  def down
    remove_foreign_key :pivotal_stories_owners, :pivotal_stories
    add_foreign_key :pivotal_stories_owners, :pivotal_stories
  end
end
