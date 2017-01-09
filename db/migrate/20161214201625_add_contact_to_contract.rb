class AddContactToContract < ActiveRecord::Migration[5.0]
  def change
    add_reference :contracts, :contact, foreign_key: true
  end
end
