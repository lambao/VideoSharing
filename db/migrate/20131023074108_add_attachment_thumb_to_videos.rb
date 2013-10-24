class AddAttachmentThumbToVideos < ActiveRecord::Migration
  def self.up
    change_table :videos do |t|
      t.attachment :thumb
    end
  end

  def self.down
    drop_attached_file :videos, :thumb
  end
end
