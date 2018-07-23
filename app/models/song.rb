class Song < ApplicationRecord
  validates :name, uniqueness: { scope: :artist, message: "Song already exists"}

  has_many :users, through: :playlists
  has_many :song_playlists
  has_many :playlists, through: :song_playlists
end
