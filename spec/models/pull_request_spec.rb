require 'rails_helper'

RSpec.describe PullRequest do

  describe '.sync_with_github' do

    it "syncs with github", :vcr do
      pr = FactoryBot.create(
        :pull_request,
        pull_request_link: "https://github.com/testdash/fake-repo/pull/2",
        state: "open",
        pull_request_number: "2",
        title: "Pull Request Test",
        repository_name: "testdash/fake-repo"
        )
      user_bot = FactoryBot.create(
        :user,
        name: "ombu-bot"
        )

      PullRequest.sync_with_github

      pr.reload

      expect(pr.state).to eq("open")
      expect(pr.assignees).to include(user_bot)
    end

    it "deletes all open pull requests that aren't found", :vcr do
      pull_request = FactoryBot.create(:pull_request)

      PullRequest.sync_with_github

      expect(PullRequest.all).to be_empty
    end
  end
end
