class Groupcampaign < ApplicationRecord
  belongs_to :campaign
  belongs_to :group
end
