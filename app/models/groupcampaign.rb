# == Schema Information
#
# Table name: groupcampaigns
#
#  id          :integer          not null, primary key
#  campaign_id :integer
#  group_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Groupcampaign < ApplicationRecord
  belongs_to :campaign
  belongs_to :group
end
