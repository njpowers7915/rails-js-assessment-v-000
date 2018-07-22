class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(name: params[:session][:name])
    if @user && @user.authenticate(params[:session][:password])
      #log_in(@user)
      session[:user_id] = @user.id
      redirect_to @user#, notice: "Welcome back to APP NAME"
    else
      #Error Message
      #flash[:danger] = 'Invalid name/password combination'
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end

end
