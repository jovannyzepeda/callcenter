class Campaign < ApplicationRecord
	belongs_to :company
	validates :nombre, presence: true
	validates :company, presence: true
	has_many :groupcampaign
	has_many :group, through: :groupcampaign
end
