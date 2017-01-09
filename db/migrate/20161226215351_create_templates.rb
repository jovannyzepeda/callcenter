class CreateTemplates < ActiveRecord::Migration[5.0]
  def change
    create_table :templates do |t|
      t.references :company, foreign_key: true
      t.string :lenguaje

      t.timestamps
    end
  end
end
