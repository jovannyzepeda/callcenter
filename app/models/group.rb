# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  nombre     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  eliminado  :boolean          default("0")
#

class Group < ApplicationRecord
	has_many :groupcampaign
	has_many :campaigns, through: :groupcampaign
	has_many :usergroup
	has_many :users, through: :usergroup
end
