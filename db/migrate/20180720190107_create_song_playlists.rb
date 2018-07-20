class CreateSongPlaylists < ActiveRecord::Migration[5.2]
  def change
    create_table :song_playlists do |t|
      t.integer :song_id
      t.integer :playlist_id
    end
  end
end
