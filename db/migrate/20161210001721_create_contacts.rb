class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.string :cliente
      t.string :telefono
      t.references :campaign, foreign_key: true

      t.timestamps
    end
  end
end
