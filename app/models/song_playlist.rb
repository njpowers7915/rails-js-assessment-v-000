class SongPlaylist < ApplicationRecord
  validates :song_id, uniqueness: {scope: :playlist_id, message: "Song already exists in this playlist"}

  belongs_to :song
  belongs_to :playlist
end
