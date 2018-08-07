class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  has_many :playlists
  has_many :songs, through: :playlists

  PLAYLISTS = []
  SONGS = []


  def like_playlist(playlist)
    #if !PLAYLISTS.nil?
      PLAYLISTS << playlist
      playlist.likes = playlist.likes + 1
      playlist.save
    #else
      #PLAYLISTS = [playlist]
    #end
  end

  def liked_songs
    if !PLAYLISTS.nil?
      PLAYLISTS.each do |playlist|
        playlist.songs.each do |song|
          if !SONGS.include?(song)
            SONGS << song
          end
        end
      end
    end
    SONGS
  end

end
