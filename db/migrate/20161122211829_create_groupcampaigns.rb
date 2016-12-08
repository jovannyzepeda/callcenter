class CreateGroupcampaigns < ActiveRecord::Migration[5.0]
  def change
    create_table :groupcampaigns do |t|
      t.references :campaign, foreign_key: true
      t.references :group, foreign_key: true

      t.timestamps
    end
  end
end
