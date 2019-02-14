class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Logged In Successfully"
    else
      flash[:alert] = 'Credentials Incorrect'
      redirect_to login_path
    end
  end
end
