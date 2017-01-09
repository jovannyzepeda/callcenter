# == Schema Information
#
# Table name: companycampaigns
#
#  id          :integer          not null, primary key
#  company_id  :integer
#  campaign_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Companycampaign < ApplicationRecord
  belongs_to :company
  belongs_to :campaign
end
