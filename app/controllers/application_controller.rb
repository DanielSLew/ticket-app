class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :same_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:alert] = "Must be logged in to do that."
      redirect_to root_path
    end
  end

  def same_user(user)
    if current_user != user
      redirect_to root_path, alert: "You are not authorized to do that."
    end
  end

  private

  def save_session
    session[:user_id] = @user.id
    session[:username] = @user.username
  end
end
