class AddDateCloseToContacts < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :date_close, :date
  end
end
