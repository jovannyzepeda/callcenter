class AddContentToNotification < ActiveRecord::Migration[5.0]
  def change
    add_column :notifications, :content, :string
  end
end
