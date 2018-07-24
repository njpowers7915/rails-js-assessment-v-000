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

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])
    play_song
    redirect_to user_playlist_path(@user, @playlist)
  end

  def index
    if logged_in?
      if is_admin?
        @song = Song.new
        @songs = Song.all
      else
        @songs = Song.all
        #if current_user.songs.nil?
        #  redirect_to current_user
        #else
        #  @songs = current_user.songs
        #end
      end
    else
      redirect_to '/'
    end
  end

  def show
    @song = Song.find_by_id(params[:id])
  end

  private

  def song_params
    params.require(:song).permit(:name, :artist, :genre, :plays)
  end
end
