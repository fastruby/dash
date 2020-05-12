require 'rails_helper'

RSpec.describe PullRequestWorker, type: :worker do

  describe "perform method" do

    it "saves the pull requests into the database", :vcr do
      FactoryBot.create(:user, name: "ombu-bot")

      PullRequestWorker.new.perform(ENV['PERSONAL_ACCESS_TOKEN'])

      expect(PullRequest.count).to eq 1
    end

    it "removes closed pull requests", :vcr do
      FactoryBot.create(:user, name: "ombu-bot")
      FactoryBot.create(:pull_request)

      PullRequestWorker.new.perform(ENV['PERSONAL_ACCESS_TOKEN'])

      expect(PullRequest.count).to eq 1
    end
  end
end
