class SongsController < ApplicationController
  helper_method :params
  include SongsHelper

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
    @song.play_song
    @user = session[:user_id]
    @playlist = session[:playlist_id]
    redirect_to user_playlist_path(@user, @playlist)
  end

  def index
    if logged_in?
      if is_admin?
        @songs = Song.all #SORT BY NAME
      #elsif params["attribute"] == "popular"
      #  if params
      #  @songs = Song.most_popular
        #SORT BY MOST PLAYS
      elsif params["attribute"] == "artist"
        @artist = slug_to_name(params["name"])
        @songs = Song.by_artist(@artist)
        #SORT BY MOST PLAYLISTS
      elsif params["attribute"] == "genre"
        @genre = slug(params["name"])
        @songs = Song.by_genre(@genre)
      else
        @songs = Song.all
        #SORT BY NAME
      end
    else
      redirect_to '/'
    end
  end

  def show
    if params[:id] == "most_popular" || params["attribute"] == "popular"
      @songs = Song.most_popular

      render 'index'
    else
      @song = Song.find_by_id(params[:id])
    end
  end

  private

  def song_params
    params.require(:song).permit(:name, :artist, :genre, :plays)
  end
end
