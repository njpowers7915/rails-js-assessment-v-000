class Playlist < ApplicationRecord
  belongs_to :user
  has_many :song_playlists
  has_many :songs, through: :song_playlists

  def remove_song_from_playlist(song)
    @songs = self.songs
    @songs.find_by_id(song.id).delete
    self.save
    #song = @songs.find_by(name: params["song"]["name"], artist: params["song"]["artist"])
    #@songs.delete(song)
    #@songs.save
    #binding.pry
  end

end
