class User < ApplicationRecord
  has_secure_password
  validates :name, format: { without: /[0-9]/, message: "does not allow numbers" }
  validates :email, uniqueness: true

  has_many :songs, through: :playlists
  has_many :playlists
end
