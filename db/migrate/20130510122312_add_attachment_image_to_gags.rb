class AddAttachmentImageToGags < ActiveRecord::Migration
  def self.up
    change_table :gags do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :gags, :image
  end
end
