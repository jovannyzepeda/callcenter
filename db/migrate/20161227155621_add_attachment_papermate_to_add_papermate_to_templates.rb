class AddAttachmentPapermateToAddPapermateToTemplates < ActiveRecord::Migration
  def self.up
    change_table :templates do |t|
      t.attachment :papermate
    end
  end

  def self.down
    remove_attachment :templates, :papermate
  end
end
