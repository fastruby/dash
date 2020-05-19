require 'rails_helper'

RSpec.describe Issue do

  describe '.sync_with_github' do

      it "deletes issues that are no longer open", :vcr  do
        issue = FactoryBot.create(:issue)

        Issue.sync_with_github
        expect(Issue.all).to be_empty
      end

      it "updates issues that are open", :vcr do
        user_bot = FactoryBot.create(:user,
                                    name: "ombu-bot",
                                    id: 1)

        open_issue = FactoryBot.create(:issue,
                                      repository_name: "TestDash/fake-repo",
                                      issue_number: "1")

        Issue.sync_with_github
        expect(open_issue.assignees.count).to eq 1
      end
  end
end
