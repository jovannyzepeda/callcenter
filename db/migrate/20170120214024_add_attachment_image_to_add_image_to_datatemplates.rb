class AddAttachmentImageToAddImageToDatatemplates < ActiveRecord::Migration
  def self.up
    change_table :datatemplates do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :datatemplates, :image
  end
end
