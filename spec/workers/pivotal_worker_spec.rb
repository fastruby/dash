require 'rails_helper'

RSpec.describe PivotalWorker, type: :worker do

  describe "perform method" do
    let(:user_bot) do
      FactoryBot.create(:user,
        name: "ombu-bot",
        id: 3,
        pivotal_token: ENV["PIVOTAL_TOKEN"],
        pivotal_id: nil
      )
    end

    context "when there are new stories" do
      it "saves the stories into the database", :vcr do
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

    context "when stories are deleted in Pivotal Tracker" do
      let!(:project) { FactoryBot.create(:pivotal_project, pivotal_id: "2445808") }

      it "deletes the stories from database", :vcr do
        pivotal_story = FactoryBot.create(:pivotal_story, project_name: "The Test")
        PivotalWorker.new.perform(user_bot.id)
        expect(PivotalStory.exists?(id: pivotal_story.id)).to be_falsey
      end

      it "doesn't delete stories from a different project", :vcr do
        pivotal_story = FactoryBot.create(:pivotal_story)

        PivotalWorker.new.perform(user_bot.id)
        expect(PivotalStory.exists?(id: pivotal_story.id)).to be_truthy
      end
    end
  end
end
