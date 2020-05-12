
require 'rails_helper'

RSpec.describe PivotalStory do

  describe '.create_update_pivotal_story' do

    it "updates the state of the stories" do
      story = FactoryBot.create(:pivotal_story,
                                state: "unstarted",
                                name: "MyTest",
                                story_link: "www.link.com",
                                project_link: "www.link/project_id",
                                story_number: 5)
      user = FactoryBot.create(:user,
                              pivotal_id: 4578)
      pivotal_story =
        TrackerApi::Resources::Story.new(
          url: "www.linktest.com",
          name: "MyTestChanged",
          current_state: "started",
          project_id: 78593,
          id: 5,
          owner_ids: [4578]
        )
      PivotalStory.create_update_pivotal_story(pivotal_story, "The Project")

      story.reload

      expect(story.state).to eq("started")
      expect(story.name).to eq("MyTestChanged")
      expect(story.project_link).to eq("https://www.pivotaltracker.com/n/projects/78593")
      expect(story.project_name).to eq("The Project")
      expect(story.story_link).to eq("www.linktest.com")
      expect(story.users).to include(user)
    end
  end
end
