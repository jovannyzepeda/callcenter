class CreateDatatemplates < ActiveRecord::Migration[5.0]
  def change
    create_table :datatemplates do |t|
      t.references :template, foreign_key: true
      t.text :content
      t.integer :width
      t.integer :height
      t.integer :fontsize

      t.timestamps
    end
  end
end
