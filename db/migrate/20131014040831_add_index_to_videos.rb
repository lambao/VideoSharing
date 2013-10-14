class AddIndexToVideos < ActiveRecord::Migration
  def change
    add_index(:videos, :created_at, order: { name: :desc })
    add_index(:videos, :youtube_id)
    add_index(:videos, :view_count)
    add_index(:videos, :user_id)
  end
end
