
class SessionsController < ApplicationController

  def new
    session[:user_id] = nil
  end

  def create
    @user = User.where(:email => params.fetch(:email, '')).first
    if @user
      if @user.email_valid
        if User.authenticate(@user.email, params.fetch(:password, ''))
          session[:user_id] = @user.id
          redirect_to root_path
          return false
        end
      else
        flash[:error] = 'Your email has not been validated'
        @validate_email_link = true
        render :new
        return false
      end
    end
    flash[:error] = 'Login failed'
    render :new
    return false
  end

  def destroy
    reset_session
    redirect_to root_path
    return false
  end

end
