class PlaylistsController < ApplicationController
  def new
    @playlist = Playlist.new(user_id: params[:id])
  end

  def create
    @playlist = Playlist.new(playlist_params)
    @playlist.user = User.find_by_id(session[:user_id])
    if @playlist.save
      #if user_params[:admin] == "0"
        session[:playlist_id] = @playlist.id
        #format.html { redirect_to @user, notice: "Welcome to APP NAME!" }
        redirect_to playlist_path(@playlist)
      #elsif user_params[:admin] == "1"
      #  admin_signup
      #end
    else
      render 'new'
      #format.html { render :new }
    end
  end

  def show
    if Playlist.find_by_id(session[:playlist_id])
      @playlist = Playlist.find_by_id(session[:playlist_id])
      #@attraction = Attraction.find_by_id(session[:attraction_id])

    else
      #ERROR MESSAGE
      #redirect_to '/'
    end
  end

  def edit
    @playlist = Playlist.find(params[:id])
    @songs = Song.all
  end

  def update
    @playlist = Playlist.find(params[:id])
    if @playlist.update_attributes(playlist_params)
      if params["playlist"]["song"]
        song_array = params["playlist"]["song"].split(" --- ")
        song = Song.find_by(name: song_array[0], artist: song_array[1])
        binding.pry
      else
        redirect_to playlist_path(@playlist)
      end
    else
      render 'edit'
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
    params.require(:playlist).permit(:title, :description, :private, :user_id)
  end
end
