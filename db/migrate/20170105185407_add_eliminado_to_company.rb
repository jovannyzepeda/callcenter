class AddEliminadoToCompany < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :eliminado, :boolean, :default =>  false
  end
end
