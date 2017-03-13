class AddAttachmentFirmaToAddFirmaToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :firma
    end
  end

  def self.down
    remove_attachment :users, :firma
  end
end
