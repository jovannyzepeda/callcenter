class CreateCompanycampaigns < ActiveRecord::Migration[5.0]
  def change
    create_table :companycampaigns do |t|
      t.references :company, foreign_key: true
      t.references :campaign, foreign_key: true

      t.timestamps
    end
  end
end
