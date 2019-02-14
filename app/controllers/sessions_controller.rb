class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = 'Logged In Successfully'
      redirect_to dashboard_path
    else
      flash[:alert] = 'Credentials Incorrect'
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    flash[:success] = "You have logged out"
    redirect_to root_path
  end
end
