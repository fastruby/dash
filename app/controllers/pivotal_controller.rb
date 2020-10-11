class PivotalController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    if current_user.update(pivotal_token_params)
      redirect_to todos_path, :flash => {
        :notice => "Your pivotal tracker id was updated!"
      }
    else
      flash[:error] = current_user.errors.full_messages.first
      render :edit
    end
  end

  private

  def pivotal_token_params
    params.require(:user).permit(:pivotal_token)
  end
end
