class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save
    if @user.valid?
      flash[:notice] = 'Almost done, please check your email.'
      #@mail = UserMailer.validate_email(@user)
      #@mail.deliver_now
      redirect_to login_path
      return false
    end
    flash[:error] = 'An error occured'
    render :new
  end

  private

  def user_params
    params.require(:user).permit(:fname, :lname, :username, :email, :password, :password_confirmation)
  end

end
