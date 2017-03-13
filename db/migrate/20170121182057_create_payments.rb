class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.references :contract
      t.float :cantidad
      t.integer :numero
      t.references :user
      t.boolean :status, default: false
      t.date :fecha_cierre

      t.timestamps
    end
  end
end
