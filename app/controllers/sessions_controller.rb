class SessionsController < ApplicationController

  def new
  end

  def create
    if params[:session][:name]
      @user = User.find_by(name: params[:session][:name])
      if @user && @user.authenticate(params[:session][:password])
        session[:user_id] = @user.id
        redirect_to @user
      else
        flash[:danger] = 'Invalid name/password combination'
        redirect_to login_path
      end
    else
      @user = User.find_or_create_by(uid: auth['uid']) do |u|
        u.name = auth['info']['name']
        u.email = auth['info']['email']
        u.image = auth['info']['image']
      end
      session[:user_id] = @user.id
      render 'welcome/home'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end

  private

  def auth
    request.env['omniauth.auth']
  end

end
