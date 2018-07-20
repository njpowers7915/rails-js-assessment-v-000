class Playlist < ApplicationRecord
  belongs_to :user
  has_many :songs, throug: :song_playlists
end
