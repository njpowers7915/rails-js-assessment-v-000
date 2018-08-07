class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  has_many :playlists
  has_many :songs, through: :playlists


  #PLAYLISTS = []
  #SONGS = []


  def like_playlist(playlist)
    playlist.likes = playlist.likes + 1
    playlist.save
    self.songs << playlist.songs
  end

  #def liked_playlists
  #  array = self.playlists
  #  self.playlists +
  #end

  #def liked_songs
  #  liked_songs = self.songs + self.liked_playlists.songs
    #if !self.liked_playlists.nil?
    #  self.liked_playlists.each do |playlist|
    #    playlist.songs.each do |song|
    #      if !SONGS.include?(song)
    #        SONGS << song
    #      end
    #    end
    #  end
    #end
    #SONGS
  #end

end
