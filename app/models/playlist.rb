class Playlist < ApplicationRecord
  belongs_to :user
  has_many :song_playlists
  has_many :songs, through: :song_playlists

  def remove_song_from_playlist(song)
    self.songs.delete(song)
  end

end
