class Song < ApplicationRecord
  has_many :users, thorugh: :playlists
  has_many :playlists, through: :song_playlists 
end
