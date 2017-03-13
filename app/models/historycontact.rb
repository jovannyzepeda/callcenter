# == Schema Information
#
# Table name: historycontacts
#
#  id                      :integer          not null, primary key
#  contact_id              :integer
#  user_id                 :integer
#  title                   :string(255)
#  content                 :text(65535)
#  email                   :string(255)
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  attachment_file_name    :string(255)
#  attachment_content_type :string(255)
#  attachment_file_size    :integer
#  attachment_updated_at   :datetime
#

class Historycontact < ApplicationRecord
  belongs_to :contact
  belongs_to :user
  has_attached_file :attachment
  do_not_validate_attachment_file_type :attachment
  after_save :send_mail_contact
  after_save :send_mail
  include Notificable
  def send_mail_contact
    #notificaciones para envió de correo
    if self.email
      if self.user.is_recepcion?
        notification_singular(self,self.contact.user)
      else
        #notificaciones de correo para usuarios normales
          if self.to_user == "Legal department" || self.user.is_abogado?
            notification_singular(self,self.contact.campaign.company.user)
          else
            notification_plural(self,self.contact.campaign.company.users)
          end
        
      end
    else
        if self.to_user == "Legal department"
          notification_singular(self,self.contact.campaign.company.user)
        elsif self.to_user == "Contact department"
          notification_plural(self,self.contact.campaign.company.users)
        elsif self.to_user == "lawyer"
          if self.contact.contactabogado.present?
            notification_singular(self,self.contact.contactabogado.user)
          end
        end
        if self.to_user.blank? && self.user.is_abogado?
          notification_singular(self, self.contact.user)
        end
    end
  end 
  def notification_singular(element,user)
    send_notifications_to_users(element.contact,"#{element.user.nombre} ha integrado nueva información
      para el cliente #{element.contact.cliente}",set_array_user(user))
  end
  def notification_plural(element,users)
    send_notifications_to_users(element.contact,"#{element.user.nombre} ha integrado nueva información
      para el cliente #{element.contact.cliente}",set_array_users(users))
  end
  def send_mail
    if self.email
      if self.user.is_recepcion?
        SendMailerJob.perform_later(self,self.contact)
      end
    end
  end 
end
