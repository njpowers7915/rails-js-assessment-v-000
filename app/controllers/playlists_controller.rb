class PlaylistsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @playlist = @user.playlists.build(user_id: params[:id])
    #@playlist.build(user_id: params[:id])
  end

  def create
    @playlist = Playlist.new(playlist_params)
    @user = User.find(params[:user_id])
    @playlist.user = @user
    if @playlist.save
        session[:playlist_id] = @playlist.id
        @user.like_playlist(@playlist)
        @user.save
        redirect_to user_playlist_path(@user, @playlist)
    else
      render 'new'
    end
  end

  def show
    if Playlist.find_by_id(params[:id])
      @playlist = Playlist.find_by_id(params[:id])
      session[:playlist_id] = @playlist.id
      @user = User.find_by_id(session[:user_id])
      @songs = @playlist.songs
    end
  end

  def edit
    @playlist = Playlist.find(params[:id])
    @user = @playlist.user
    @songs = Song.all
  end

  def update
    @playlist = Playlist.find(params[:id])
    @user = @playlist.user
    if !params["playlist"]["song"]["delete"]
      if @playlist.update_attributes(playlist_params)
        if params["playlist"]["song"] && !params["playlist"]["song"].empty?
          song_array = params["playlist"]["song"].split(" --- ")
          if song = Song.find_by(name: song_array[0], artist: song_array[1])
            song = Song.find_by(name: song_array[0], artist: song_array[1])
            if !@playlist.songs.include?(song)
              @playlist.songs << song
              redirect_to user_playlist_path(@user, @playlist)
            else
              flash[:notice] = "Song already exists in this playlist"
              redirect_to user_playlist_path(@user, @playlist)
            end
          else
            flash[:notice] = "Song does not exist"
            redirect_to user_playlist_path(@user, @playlist)
          end
        else
          @playlist.update_attributes(playlist_params)
          redirect_to user_playlist_path(@user, @playlist)
        end
      else
        render 'edit'
      end
    end
  end

  def index
    if logged_in?
      if is_admin?
        @playlists = Playlist.all
      else
        @playlists = Playlist.all.where(private: false)
      end
    else
      redirect_to '/'
    end
  end

  private

  def playlist_params
    params.require(:playlist).permit(:title, :description, :private, :user_id, :likes)
  end
end
