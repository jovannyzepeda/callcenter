class AddNumberToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :number, :integer
  end
end
