# == Schema Information
#
# Table name: campaigns
#
#  id         :integer          not null, primary key
#  nombre     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :integer
#

class Campaign < ApplicationRecord
	belongs_to :company
	validates :nombre, presence: true
	validates :company, presence: true
	has_many :contacts
	has_many :groupcampaign
	has_many :groups, through: :groupcampaign
	protected
		def self.get_users(id)
			users = Array.new
			campaign = Campaign.find(id)
			campaign.groups.activos.each do |group|
				group.users.each do |user|
					if user.is_active?
						users.push user
					end
				end
			end
			return users
		end
end
 
