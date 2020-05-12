require 'rails_helper'

RSpec.describe IssueWorker, type: :worker do

  describe "perform method" do

    it "saves the issues into the database", :vcr do
      FactoryBot.create(:user, name: "ombu-bot")

      IssueWorker.new.perform(ENV['PERSONAL_ACCESS_TOKEN'])

      expect(Issue.count).to eq 1
    end

    it "removes closed issues from the database", :vcr do
      FactoryBot.create(:user, name: "ombu-bot")
      FactoryBot.create(:issue)

      IssueWorker.new.perform(ENV['PERSONAL_ACCESS_TOKEN'])

      expect(Issue.count).to eq 1
    end
  end
end
