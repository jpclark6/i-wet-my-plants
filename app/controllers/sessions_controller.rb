class SessionsController < ApplicationController
  def create
    facebook_user(auth_hash)
  end

  def destroy
    session.clear
    flash[:success] = "You have logged out"
    redirect_to root_path
  end

  def guest
    user = User.find_by(uid: '423145')
    session[:user_id] = user.id
    flash[:success] = "Welcome to the guest public account."
    redirect_to plants_path
  end

  private

  def auth_hash
    request.env["omniauth.auth"]
  end

  def facebook_user(auth_hash)
    user = User.find_or_create_from_auth_hash(auth_hash)
    if user.save && user.garden == nil
      session[:user_id] = user.id
      redirect_to new_garden_path
    else user.save && user.garden != nil
      session[:user_id] = user.id
      flash[:success] = "Welcome back #{user.name}."
      redirect_to plants_path
    end
  end

end
