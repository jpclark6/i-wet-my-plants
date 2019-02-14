class ApplicationController < ActionController::Base
  helper_method :current_user, :current_garden

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_garden
    if current_user
      current_user.garden
    end
  end
end
