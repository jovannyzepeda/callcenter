class AddDataToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :meta, :float
    add_column :users, :privilegio, :integer
  end
end
