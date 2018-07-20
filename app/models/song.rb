class Song < ApplicationRecord
  has_many :users, thorugh: :playlists
  has_and_belongs_to_many :playlists
end
