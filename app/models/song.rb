class Song < ApplicationRecord
  validates :name, uniqueness: { scope: :artist, message: "Song already exists for this artist"}

  has_many :song_playlists
  has_many :playlists, through: :song_playlists
  has_many :users, through: :playlists

  def play_song
    self.update_attribute(:plays, (self.plays + 1))
  end

  def self.by_artist(artist)
    where(artist: artist).order("songs.name ASC")
  end

  def self.sort
    order("songs.artist ASC").order("songs.name ASC")
  end

  def self.by_genre(genre)
    where(genre: genre).order("songs.artist ASC").order("songs.name ASC")
  end

  def self.most_popular
    order("songs.plays DESC").order("songs.artist ASC").order("songs.name ASC")
  end

end
