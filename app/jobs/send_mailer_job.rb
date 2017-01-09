class SendMailerJob < ApplicationJob
  queue_as :default

  def perform(historycontact,contact)
    Notificacion.send_email(historycontact,contact).deliver
  end
end
