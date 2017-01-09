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
    if self.email
      if self.user.is_recepcion?
        send_notifications_to_users(self.contact,
          "#{self.user.nombre} Ha enviado el mensaje solicitado para #{self.contact.cliente}",
          set_array_user(self.contact.user))
      else
        send_notifications_to_users(self.contact,
            "#{self.user.nombre} Ha solicitado enviar el contrato del cliente 
              #{self.contact.cliente} en el correo #{self.email}",
              set_array_users(self.contact.campaign.company.users))
      end
    end
  end 
  def send_mail
    if self.email
      if self.user.is_recepcion?
        SendMailerJob.perform_later(self,self.contact)
      end
    end
  end 
end
