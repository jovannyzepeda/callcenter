class AddDataToContac < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :fax, :string
    add_column :contacts, :correo, :string
    add_column :contacts, :city, :string
    add_column :contacts, :country, :string
    add_column :contacts, :unit_size, :string
    add_column :contacts, :season, :string
    add_column :contacts, :resort, :string
  end
end
