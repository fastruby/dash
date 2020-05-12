class AddStoryNumberIndexToPivotalStories < ActiveRecord::Migration[6.0]
  def change
    add_index(:pivotal_stories, :story_number, unique: true)
  end
end
