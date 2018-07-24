class Song < ApplicationRecord
  validates :name, uniqueness: { scope: :artist, message: "Song already exists"}

  has_many :users, through: :playlists
  has_many :song_playlists
  has_many :playlists, through: :song_playlists

  #def add_song
  #end

  #def play_song
#    self.update_attribute(:plays, (self.plays + 1))
#  end

end
