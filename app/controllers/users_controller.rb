class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_session_url, notice: "You have successfully Signed up!"
    else
      render :new
    end
  end


  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :admin, :salt, :encrypted_password)
  end
end
