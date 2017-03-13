class CreateSignempresas < ActiveRecord::Migration[5.0]
  def change
    create_table :signempresas do |t|
      t.references :user, foreign_key: true
      t.references :company, foreign_key: true
      t.string	   :nombre
      t.boolean   :eliminado, :default =>  false
      t.timestamps
    end
  end
end
