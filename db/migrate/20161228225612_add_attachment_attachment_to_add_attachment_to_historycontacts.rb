class AddAttachmentAttachmentToAddAttachmentToHistorycontacts < ActiveRecord::Migration
  def self.up
    change_table :historycontacts do |t|
      t.attachment :attachment
    end
  end

  def self.down
    remove_attachment :historycontacts, :attachment
  end
end
