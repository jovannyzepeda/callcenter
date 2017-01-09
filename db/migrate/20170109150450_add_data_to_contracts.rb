class AddDataToContracts < ActiveRecord::Migration[5.0]
  def change
    add_column :contracts, :unit_size, :string
    add_column :contracts, :country, :string
    add_column :contracts, :city, :string
    add_column :contracts, :resort, :string
  end
end
