# == Schema Information
#
# Table name: contracts
#
#  id                   :integer          not null, primary key
#  campaign_id          :integer
#  date                 :date
#  user_id              :integer
#  season               :string(255)
#  portfolio_number     :string(255)
#  membership           :string(255)
#  membership_number    :string(255)
#  membership_size      :string(255)
#  membership_type      :string(255)
#  mail                 :string(255)
#  sell_price           :float(24)
#  number_weeks         :float(24)
#  price_week           :float(24)
#  price_rent           :float(24)
#  tipo                 :string(255)
#  owner                :string(255)
#  legal_representative :string(255)
#  atipogente           :string(255)
#  commission           :float(24)
#  coowner              :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  contact_id           :integer
#

class Contract < ApplicationRecord
  belongs_to :campaing
  belongs_to :user
  belongs_to :contact
  after_create :send_data
  validates :owner, presence: true
  include Notificable
  	def send_data
        send_notifications_to_users(self.contact,
          "#{self.user.nombre} Ha creado el contrato para el cliente #{self.contact.cliente}",
          set_array_users(self.contact.campaign.company.users))
   	end
end
 