class SendnotificationJob < ApplicationJob
  queue_as :default

  def perform(item,mensaje,users)
  	users.each do |user|
    	Notification.create(item: item, user_id: user.id, content: mensaje)
    end
  end
end
