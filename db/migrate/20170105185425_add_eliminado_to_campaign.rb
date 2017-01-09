class AddEliminadoToCampaign < ActiveRecord::Migration[5.0]
  def change
    add_column :campaigns, :eliminado, :boolean, :default =>  false
  end
end
