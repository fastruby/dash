class PivotalStoriesOwner < ApplicationRecord
  belongs_to :user
  belongs_to :pivotal_story
end
