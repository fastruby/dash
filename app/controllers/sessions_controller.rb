class SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    session[:access_token] = auth["credentials"]["token"]
    redirect_to root_url, :notice => "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to home_path, :notice => "Signed out!"
  end

  def failure
    redirect_to home_path, :flash => { :error => "We couldn't sign you in! (Error: #{params[:message]})" }
  end
end
