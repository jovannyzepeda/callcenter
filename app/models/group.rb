class Group < ApplicationRecord
	has_many :groupcampaign
	has_many :campaign, through: :groupcampaign
	has_many :usergroup
	has_many :user, through: :usergroup
end
