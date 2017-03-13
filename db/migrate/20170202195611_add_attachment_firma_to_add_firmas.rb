class AddAttachmentFirmaToAddFirmas < ActiveRecord::Migration
  def self.up
    change_table :signempresas do |t|
      t.attachment :firma
    end
  end

  def self.down
    remove_attachment :signempresas, :firma
  end
end
