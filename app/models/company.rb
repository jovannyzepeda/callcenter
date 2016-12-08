class Company < ApplicationRecord
	has_attached_file :logo, styles: { medium: "300x300>", thumb: "50x50>" }, default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/
  	validates :nombre, :presence => true
  	has_many :companycampaign
  	has_many :campaign, through: :companycampaign
end
