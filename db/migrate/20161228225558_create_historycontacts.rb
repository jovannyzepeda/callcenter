class CreateHistorycontacts < ActiveRecord::Migration[5.0]
  def change
    create_table :historycontacts do |t|
      t.references :contact, foreign_key: true
      t.references :user, foreign_key: true
      t.string :title
      t.text :content
      t.string :email

      t.timestamps
    end
  end
end
