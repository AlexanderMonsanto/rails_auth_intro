class PasswordsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email(params[:user][:email])

    if @user
      @user.set_password_reset
      UserMailer.password_reset(@user).deliver
    end

    flash[:warning] = "Password Reset Sent"
    redirect_to login_path
  end

  def update
    @user = User.find_by_reset_code(params[:code])
    @user.password = params[:password]
    @user.save

    redirect_to login_path
  end
end
