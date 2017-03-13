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
#  lenguaje             :string(255)
#  unit_size            :string(255)
#  country              :string(255)
#  city                 :string(255)
#  resort               :string(255)
#

class Contract < ApplicationRecord
  belongs_to :campaing
  belongs_to :user
  belongs_to :contact
  has_many :payments
  after_create :send_data
  validates :owner, presence: true
  include Notificable
  	def send_data
        send_notifications_to_users(self.contact,
          "#{self.user.nombre} Ha creado el contrato para el cliente #{self.contact.cliente}",
          set_array_users(self.contact.campaign.company.users))
   	end
    def self.reemplace_text(text, contrato)
      text = text.gsub('_sell_price', " #{contrato.sell_price}")
      text = text.gsub('_campaign', " #{contrato.contact.campaign.nombre}")
      text = text.gsub('_date', " #{contrato.date}")
      text = text.gsub('_contract', "#{contrato.contact.campaign.company.nombre.upcase}-#{contrato.date.strftime('%y')}#{contrato.id}#{contrato.date.strftime('%m')}#{contrato.contact.id}#{contrato.date.strftime('%d')}")
      if contrato.contact.date_close.present?
        text = text.gsub('_datcancell', " #{contrato.contact.date_close.strftime('%d - %m - %Y')}")
      end
      text = text.gsub('_season', " #{contrato.season}")
      text = text.gsub('_portfolio_number', " #{contrato.portfolio_number}")
      text = text.gsub('_membership', " #{contrato.membership}")
      text = text.gsub('_nmembership_number', " #{contrato.membership_number}")
      text = text.gsub('_tmembership_type', " #{contrato.membership_type}")
      text = text.gsub('_mail', " #{contrato.mail}")
      text = text.gsub('_number_weeks', " #{contrato.number_weeks}")
      text = text.gsub('_wprice_week', " #{contrato.price_week}")
      text = text.gsub('_rprice_rent', " #{contrato.price_rent}")
      text = text.gsub('_type', " #{contrato.tipo}")
      text = text.gsub('_owner', " #{contrato.owner}")
      text = text.gsub('_coowner', " #{contrato.coowner}")
      text = text.gsub('_city', " #{contrato.city}")
      text = text.gsub('_country', " #{contrato.country}")
      text = text.gsub('_resort', " #{contrato.resort}")
      text = text.gsub('_unit_size', " #{contrato.unit_size}")
      text = text.gsub('_payments', "#{Contract.table(contrato)}")
      
      user = contrato.contact.campaign.company.signempresas.where(user_id: contrato.contact.user.id).activos.last
      if user.present?
        text = text.gsub('_sign', "<img src='#{Rails.root}/public#{user.firma.url(:original, timestamp: false)}' style='margin-bottom:-15px;max-width:200px;'>")
        text = text.gsub('_user', " #{user.nombre}")
      end

      userl = contrato.contact.campaign.company.signempresas.where(user_id: contrato.contact.campaign.company.user.id).activos.last
      if userl.present?
        text = text.gsub('_wsignreprlegal', "<img src='#{Rails.root}/public#{userl.firma.url(:original, timestamp: false)}' style='margin-bottom:-15px;'>")
        text = text.gsub('_legal_representative', " #{user.nombre}")
      end
      if contrato.contact.contactabogado.present?
        usero = contrato.contact.campaign.company.signempresas.where(user_id: contrato.contact.contactabogado.user.id).activos.last
        if usero.present?
          text = text.gsub('_lsignlawy', "<img src='#{Rails.root}/public#{usero.firma.url(:original, timestamp: false)}' style='margin-bottom:-15px;'>")
          text = text.gsub('_lawyer', " #{user.nombre}")
        end
      end
      if contrato.contact.campaign.company.users.first.present?
        text = text.gsub('_asignadmingroup', "<img src='#{Rails.root}/public#{contrato.contact.campaign.company.users.first.firma.url(:original, timestamp: false)}' style='margin-bottom:-15px;'>")
      end
      return text
    end
    def self.table(contrato)
      texto = "<table style='width: 100%;max-width: 100%;margin-bottom: 20px;'>
        <thead style='background: #373a3c;color: white;'>
          <tr>
            <th style='text-align: center; padding: 10px 0px;'>#</th>
            <th style='text-align: center; padding: 10px 0px;'>Quantity</th>
            <th style='text-align: center; padding: 10px 0px;'>Date</th>
            <th style='text-align: center; padding: 10px 0px;'>Status</th>
          </tr>
        </thead>"
      contrato.payments.each.with_index do |pago, index| 
        texto << "<tr style='background: #373a3c; color: white;'>
          <td style='text-align: center; padding: 10px 0px;'>#{index + 1}</td>
          <td style='text-align: center; padding: 10px 0px;'>#{pago.cantidad}</td>
          <td style='text-align: center; padding: 10px 0px;'>#{pago.created_at.strftime('%m/%d/%Y')}</td>"
          if pago.status == true
            if contrato.lenguaje == "EN"
              texto << "<td style='text-align: center; padding: 10px 0px;'>Paid out</td>"
            else
              texto << "<td style='text-align: center; padding: 10px 0px;'>Pagado</td>"
            end
          else
            if contrato.lenguaje == "EN"
              texto << "<td style='text-align: center; padding: 10px 0px;'>To pay</td>"
            else
              texto << "<td style='text-align: center; padding: 10px 0px;'>Por pagar</td>"
            end
          end
        texto << "</tr>"
      end
      texto << "</table>"
      return texto
    end
end
 
