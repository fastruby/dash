class TodosController < ApplicationController
  before_action :check_current_user

  def index
    @my_pulls = current_user.my_pulls
    @my_issues = current_user.my_issues
    @my_pivotal_stories = current_user.pivotal_stories
    @owned_pulls = current_user.owned_pulls
  end

  def update_pull_requests
    PullRequestWorker.perform_async(session[:access_token])
    redirect_to todos_path, :flash => {
      :notice => "Syncing your pull requests, please refresh in two minutes."
    }
  end

  def update_issues
    IssueWorker.perform_async(session[:access_token])
    redirect_to todos_path, :flash => {
      :notice => "Syncing your issues, please refresh in two minutes."
    }
  end

  def update_pivotal
    if current_user.pivotal_token.blank?
      redirect_to edit_pivotal_path(current_user)
    else
      PivotalWorker.perform_async(current_user.id)
      redirect_to todos_path, :flash => {
        :notice => "Syncing your pivotal tracker stories, please refresh in two minutes."
      }
    end
  end
end
