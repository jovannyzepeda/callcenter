module Notificable
	#es para agergar tiposdeusuarios yu permisos
	extend ActiveSupport::Concern
	def send_notifications_to_users(item,mensaje,users)
		SendnotificationJob.perform_later(item,mensaje,users)
	end
	def set_array_user(user)
		objArray = Array.new
		objArray.push user
		return objArray
	end
	def set_array_users(users)
		objArray = Array.new
		users.each do |user|
			objArray.push user
		end
		return objArray
	end
end