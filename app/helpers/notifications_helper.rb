module NotificationsHelper
	def render_notifications(notificaciones)
		notificaciones.map do |notificacion|
			render partial: "notifications/show",locals:{notificacion: notificacion}
		end.join("").html_safe
	end
end