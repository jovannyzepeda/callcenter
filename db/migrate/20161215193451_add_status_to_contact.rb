class AddStatusToContact < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :status, :string
  end
end
