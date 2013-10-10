class ChangeVideosYoutubeUrlType < ActiveRecord::Migration
  def change
    change_column(:videos, :youtube_id, :text)
  end
end
