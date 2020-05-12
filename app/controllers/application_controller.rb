class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :check_current_user

  private

    def check_current_user
      redirect_to home_path if !current_user
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
end
