class PivotalController < ApplicationController
  def new
    @user = current_user
  end

  def create
    current_user.update(pivotal_token: params[:pivotal_token])
    redirect_to todos_path, :flash => {
      :notice => "Your pivotal tracker id was saved!"
    }
  end
end
