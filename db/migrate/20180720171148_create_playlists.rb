class CreatePlaylists < ActiveRecord::Migration[5.2]
  def change
    create_table :playlists do |t|
      t.string :name
      t.boolean :private, default: true
      t.integer :user_id
      t.integer :song_id

      t.timestamps
    end
  end
end
