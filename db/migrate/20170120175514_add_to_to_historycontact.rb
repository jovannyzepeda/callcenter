class AddToToHistorycontact < ActiveRecord::Migration[5.0]
  def change
    add_column :historycontacts, :to_user, :string
  end
end
