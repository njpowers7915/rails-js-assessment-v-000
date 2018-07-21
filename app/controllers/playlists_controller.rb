class PlaylistsController < ApplicationController
  def new
    @playlist = Playlist.new
  end

  def create
    @playlist = Playlist.new(playlist_params)
    if @playlist.save
      #if user_params[:admin] == "0"
        session[:playlist_id] = @playlist.id
        #format.html { redirect_to @user, notice: "Welcome to APP NAME!" }
        redirect_to @playlist
      #elsif user_params[:admin] == "1"
      #  admin_signup
      #end
    else
      render 'new'
      #format.html { render :new }
    end
  end

  private

  def playlist_params
    params.require(:playlist).permit(:title, :description, :user_id)
  end
end
