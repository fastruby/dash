require 'rails_helper'

RSpec.describe :pivotal_api_service, type: :service do
  let(:user) { FactoryBot.create(:user) }
  let(:pivotal_token) { ENV["PIVOTAL_TOKEN"] }
  let(:pivotal_service) { PivotalApiService.new(pivotal_token) }

  describe "#user_pivotal_id", :vcr do
    it "returns the user pivotal id" do
      expect(pivotal_service.user_pivotal_id).to eq 3333029
    end
  end

  describe "#update_stories", :vcr do
    it "creates the stories into the database" do
      expect{
        pivotal_service.update_stories
      }.to change(PivotalStory, :count).by 2
    end
  end
end
