# == Schema Information
#
# Table name: contacts
#
#  id          :integer          not null, primary key
#  cliente     :string(255)
#  telefono    :string(255)
#  campaign_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  status      :string(255)
#  date_close  :date
#  eliminado   :boolean          default("0")
#  fax         :string(255)
#  correo      :string(255)
#  city        :string(255)
#  country     :string(255)
#  unit_size   :string(255)
#  season      :string(255)
#  resort      :string(255)
#
 
class Contact < ApplicationRecord
  belongs_to :campaign
  has_one :contract
  has_one :user, through: :contact_user
  has_one :contact_user
  has_many :historycontacts
  validates :cliente, presence: true
  validates :telefono, presence: true
  has_one :contactabogado
  #after_create :asign_to_user
  include FunctionsConcern
  private 

  	def self.asign_to_user(campaign_id)
  		Campaign.get_users(campaign_id)

  	end
end
