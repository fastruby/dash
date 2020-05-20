require 'rails_helper'

RSpec.describe PivotalWorker, type: :worker do

  describe "perform method" do

    it "saves the stories into the database", :vcr do
      user_bot = FactoryBot.create(:user,
        name: "ombu-bot",
        id: 3,
        pivotal_token: ENV["PIVOTAL_TOKEN"],
        pivotal_id: nil
        )

      expect{
        PivotalWorker.new.perform(user_bot.id)
      }.to change(PivotalStory, :count).by 2

      user_bot.reload

      expect(user_bot.pivotal_id).to eq "3333029"

      expect(PivotalStory).not_to receive :create_update_pivotal_story
      expect(PivotalStory).not_to receive :find_by

      PivotalWorker.new.perform(user_bot.id)
    end
  end
end
