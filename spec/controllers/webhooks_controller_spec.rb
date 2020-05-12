require 'rails_helper'

RSpec.describe WebhooksController, type: :controller do
  describe "#github_webhooks" do
    context "when webhooks arrive" do
      before do
        file = JSON.parse(File.read("spec/fixtures/webhooks/#{file_name}.yml"))
        test_params = JSON.parse(file)
        post :github_webhooks, params: test_params
      end

      context "and it's a valid action" do
        let(:file_name) { "pr_assignees" }

        it "creates a PullRequest" do
          expect(PullRequest.count).to eq 1
        end
      end

      context "and it's not a valid action" do
        let(:file_name) { "pr_invalid_action" }

        it "doesn't create a PullRequest" do
          expect(PullRequest.count).to eq 0
        end
      end
    end
  end
end
