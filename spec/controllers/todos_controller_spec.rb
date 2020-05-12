require 'rails_helper'

RSpec.describe TodosController, type: :controller do
  render_views

  describe "todos#index" do
    let(:user) { FactoryBot.create(:user, name: name) }
    before do
      allow(subject).to receive(:current_user).and_return(user)
    end

    context "when user has pull request or issues" do
      let(:name) { "User1" }

      it "assigns pull requests to @my_pulls"  do
        pulls = FactoryBot.create_list(:pull_request, 3)
        allow(user).to receive(:my_pulls).and_return(pulls)
        get :index

        expect(assigns(:my_pulls)).to eq pulls
        expect(response).to render_template(:index)
        expect(response.body).to include("Pull Requests (3):")
      end

      it "assigns issues to @my_issues" do
        issues = FactoryBot.create_list(:issue, 3)
        allow(user).to receive(:my_issues).and_return(issues)
        get :index

        expect(assigns(:my_issues)).to eq issues
        expect(response).to render_template(:index)
        expect(response.body).to include("Issues (3):")
      end
    end

    context "when user has no pull requests" do
      let(:name) { "User2" }

      it "@my_pulls should be empty" do
        get :index

        expect(assigns(:my_pulls).size).to eq 0
        expect(response).to render_template(:index)
        expect(response.body).to include("You don't have any todos at the moment.")
      end
    end
  end

  describe "update_pull_requests and issues" do
    let(:user) { FactoryBot.create(:user, name: name) }
    before do
      allow(subject).to receive(:current_user).and_return(user)
    end

    context "when user pushes the sync pull_request button" do
      let(:name) { "User1" }

      it "redirects to todos page" do
        patch :update_pull_requests

        expect(response).to redirect_to '/todos'
      end
    end

    context "when user pushes the sync issues button" do
      let(:name) { "User1" }

      it "redirects to todos page" do
        patch :update_issues

        expect(response).to redirect_to '/todos'
      end
    end
  end
end
