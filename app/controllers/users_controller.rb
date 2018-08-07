class UsersController < ApplicationController
  include UsersHelper

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
        session[:user_id] = @user.id
        #@message = "Hi #{@user.name}!"
        redirect_to @user
      #elsif user_params[:admin] == "1"
      #  admin_signup
      #end
    else
      render 'new'
    end
  end

  def show
    @message = params[:message] if params[:message]
    @message ||= false

    if User.find_by_id(session[:user_id])
      @user = User.find_by_id(session[:user_id])
      @song = Song.new
      #@attraction = Attraction.find_by_id(session[:attraction_id])

    else
      redirect_to '/'
    end
  end

  def edit
    @user = User.find_by_id(session[:user_id])
  end

  def update
    @user = User.find_by_id(session[:user_id])
    if params["commit"]
      @playlist = Playlist.find_by_id(session[:playlist_id])
      @user.like_playlist(@playlist)
      @user.save
      redirect_to @user
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :admin)
  end

end
