class AddDatamailToCompany < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :security, :string
    add_column :companies, :port, :integer
    add_column :companies, :password, :string
    add_column :companies, :username, :string
    add_column :companies, :address, :string
  end
end
