class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.integer :length
      t.integer :youtube_id
      t.integer :view_count

      t.timestamps
    end
  end
end
