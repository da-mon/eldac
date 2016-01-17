class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def require_login
    if session[:user_id].nil?
      flash[:error] = 'Login required'
      redirect_to login_path
      return false
    end
    @current_user = User.where(:id => session[:user_id]).first
  end

end
