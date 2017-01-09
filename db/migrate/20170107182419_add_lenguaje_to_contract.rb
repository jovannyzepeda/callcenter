class AddLenguajeToContract < ActiveRecord::Migration[5.0]
  def change
    add_column :contracts, :lenguaje, :string
  end
end
