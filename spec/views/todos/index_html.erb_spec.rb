require "rails_helper"

RSpec.describe "todos/index" do
  before do
    controller.singleton_class.class_eval do
      protected
        def current_user
          User.new(id: 1)
        end
        helper_method :current_user
    end
  end

  it "displays the pull request's repository name" do
    assign(:my_pulls, [
      FactoryBot.create(:pull_request, repository_name: "test/repo"),
      FactoryBot.create(:pull_request, repository_name: "practice/repo")
    ])
    assign(:my_issues, [])
    assign(:my_pivotal_stories, [])
    assign(:owned_pulls, [])

    render

    expect(rendered).to include "test/repo"
    expect(rendered).to include "practice/repo"
  end

  it "displays the issue's repository name" do
    assign(:my_issues, [
      FactoryBot.create(:issue, repository_name: "test/repo"),
      FactoryBot.create(:issue, repository_name: "practice/repo")
    ])
    assign(:my_pulls, [])
    assign(:my_pivotal_stories, [])
    assign(:owned_pulls, [])

    render

    expect(rendered).to include "test/repo"
    expect(rendered).to include "practice/repo"
  end

  it "displays the pivotal tracker story's project name" do
    assign(:my_pivotal_stories, [
      FactoryBot.create(:pivotal_story, project_name: "test/project"),
      FactoryBot.create(:pivotal_story, project_name: "practice/project")
    ])
    assign(:my_issues, [])
    assign(:my_pulls, [])
    assign(:owned_pulls, [])

    render

    expect(rendered).to include "test/project"
    expect(rendered).to include "practice/project"
  end
end
