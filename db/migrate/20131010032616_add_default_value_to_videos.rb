class AddDefaultValueToVideos < ActiveRecord::Migration
  def change
    change_column(:videos, :view_count, :integer, :default => 0)
    change_column(:videos, :length, :integer, :default => 0)
  end
end
