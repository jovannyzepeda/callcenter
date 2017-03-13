class CreateContracts < ActiveRecord::Migration[5.0]
  def change
    create_table :contracts do |t|
      #t.references :campaign, foreign_key: true
      t.date :date
      t.references :user, foreign_key: true
      t.string :season
      t.string :portfolio_number
      t.string :membership
      t.string :membership_number
      t.string :membership_type
      t.string :mail
      t.float :sell_price
      t.float :number_weeks
      t.float :price_week
      t.float :price_rent
      t.string :tipo
      t.string :owner
      t.float :commission
      t.string :coowner

      t.timestamps
    end
  end
end
