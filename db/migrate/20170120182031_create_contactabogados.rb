class CreateContactabogados < ActiveRecord::Migration[5.0]
  def change
    create_table :contactabogados do |t|
      t.references :user, foreign_key: true
      t.references :contact, foreign_key: true

      t.timestamps
    end
  end
end
