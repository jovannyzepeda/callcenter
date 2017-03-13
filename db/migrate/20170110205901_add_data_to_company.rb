class AddDataToCompany < ActiveRecord::Migration[5.0]
  def change
    add_reference :companies, :user
  end
end
