class User < ApplicationRecord
  has_secure_password
  has_many :songs, through: :playlists 
  has_many :playlists
end
