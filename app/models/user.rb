class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  has_many :playlists
  has_many :songs, through: :playlists  
end
