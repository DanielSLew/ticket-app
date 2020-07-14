class SessionsController < ApplicationController
  def new
    
  end

  def create
    @user = User.where(email: params[:email]).first

    if @user && @user.authenticate(params[:password])
      save_session
      successfully_logged(:in)
    else
      flash[:alert] = "There is something wrong with your login credentials."
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    successfully_logged(:out)
  end

  private

  def successfully_logged(action)
    redirect_to root_path, notice: "You've successfully logged #{action}."    
  end
end