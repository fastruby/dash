class PivotalStory < ApplicationRecord
  has_many :pivotal_stories_owners
  has_many :users, through: :pivotal_stories_owners

  validates :story_link, presence: true

  def self.create_update_pivotal_story(story, project_name)
    _story = PivotalStory.find_or_create_by(story_number: story[:id])
    _story.update(
      name: story[:name],
      story_link: story[:url],
      project_link: project_url(story[:project_id]),
      state: story[:current_state],
      project_name: project_name,
      user_ids: get_user_ids(story[:owner_ids])
    )
  end

  def self.delete_stories_not_in_list(_stories)
    story_request_links = _stories.map {|story| story[:url] }
    PivotalStory.where.not(story_link: story_request_links).delete_all
  end

private

  def self.get_user_ids(owner_ids)
    return [] if owner_ids.nil?
    User.where(pivotal_id: owner_ids).pluck(:id)
  end

  def self.project_url(project_id)
    "https://www.pivotaltracker.com/n/projects/#{project_id}"
  end
end
