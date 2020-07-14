class SessionsController < ApplicationController
  def new
    
  end

  def create
    user = User.where(username: params[:username]).first

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to :back, notice: "You've successfully logged in."
    else
      flash[:error] = "There is something wrong with your login credentials."
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You've successfully logged out."
  end
end