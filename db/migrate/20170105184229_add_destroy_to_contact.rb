class AddDestroyToContact < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :eliminado, :boolean, :default =>  false
  end
end
