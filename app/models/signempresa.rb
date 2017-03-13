class Signempresa < ApplicationRecord
  belongs_to :user
  belongs_to :company 
  has_attached_file :firma, styles: { medium: "300x300>", thumb: "50x50>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :firma, content_type: /\Aimage\/.*\z/
  validates :nombre, :presence => true
  	
end
