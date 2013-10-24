class AddThumbRemoteUrlToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :thumb_remote_url, :string
  end
end
