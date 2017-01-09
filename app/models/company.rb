# == Schema Information
#
# Table name: companies
#
#  id                :integer          not null, primary key
#  nombre            :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  logo_file_name    :string(255)
#  logo_content_type :string(255)
#  logo_file_size    :integer
#  logo_updated_at   :datetime
#

class Company < ApplicationRecord
	has_attached_file :logo, styles: { medium: "300x300>", thumb: "50x50>" }, default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/
  	validates :nombre, :presence => true
  	has_many :companycampaign
  	has_many :templates
  	has_many :campaign, through: :companycampaign
  	has_many :usercompany
  	has_many :users, through: :usercompany
end
