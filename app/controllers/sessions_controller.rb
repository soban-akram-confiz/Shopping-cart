class SessionsController < ApplicationController

  def create
    user = login(params[:email], params[:password], params[:remember_me])
    if user
      redirect_to root_url, notice: "Logged in!"
    else
      redirect_to login_url, notice: "Email or password was invalid"
    end
  end

  def destroy
    logout
    redirect_to login_url, notice: "Logged out!"
  end

end
