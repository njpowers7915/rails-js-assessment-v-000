class SongsController < ApplicationController
  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)
    if @song.save
      #if user_params[:admin] == "0"
        session[:song_id] = @song.id
        #format.html { redirect_to @user, notice: "Welcome to APP NAME!" }
        redirect_to songs_path
      #elsif user_params[:admin] == "1"
      #  admin_signup
      #end
    else
      render 'new'
      #format.html { render :new }
    end
  end

  def index
    if logged_in?
      if is_admin?
        @songs = Song.all
      else
        #@user = current_user
        @songs = current_user.songs
      end
    else
      redirect_to '/'
    end
  end

  private

  def song_params
    params.require(:song).permit(:name, :artist, :genre)
  end
end
