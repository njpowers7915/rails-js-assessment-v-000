class SongsController < ApplicationController
  helper_method :params
  include SongsHelper

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)
    if @song.save
        session[:song_id] = @song.id
        redirect_to songs_path
    else
      render 'new'
    end
  end

  def edit
    @song = Song.find(params[:id])
  end


  def update
    @song = Song.find(params[:id])
    @playlist = session[:playlist_id]
    @user = session[:user_id]
    if params["delete"]
      current_playlist = Playlist.find_by_id(session[:playlist_id])
      current_playlist.remove_song_from_playlist(@song)
      redirect_to user_playlist_path(@user, @playlist)
    else
      @song.play_song
      #@user = session[:user_id]
      #@playlist = session[:playlist_id]
      redirect_to user_playlist_path(@user, @playlist)
    end
  end

  def index
    @song = Song.new
    if logged_in?
      if params["user_id"]
        @user = User.find_by_id(params["user_id"])

        @songs = @user.songs
      elsif is_admin?
        @songs = Song.sort
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
    @song = Song.new
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
