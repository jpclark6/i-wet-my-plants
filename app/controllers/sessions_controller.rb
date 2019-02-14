class SessionsController < ApplicationController
  def create
    facebook_user(auth_hash)
  end

  def destroy
    session.clear
    flash[:success] = "You have logged out"
    redirect_to root_path
  end

  protected

  def auth_hash
    request.env["omniauth.auth"]
  end 
  
  def facebook_user(auth_hash)
    user = User.find_or_create_from_auth_hash(auth_hash)
    if user
      flash[:success] = "Welcome #{user.name}"
      session[:user_id] = user.id
    else
      flash[:error] = "Login failed"
    end
    redirect_to plants_path
  end
  
end
