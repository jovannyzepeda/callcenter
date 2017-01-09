class AddEliminadoToGroup < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :eliminado, :boolean, :default =>  false
  end
end
