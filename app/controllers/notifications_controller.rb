class NotificationsController < ApplicationController
	before_action :set_notification, only: [:update]
	def index
		@notifications = Notification.where(user:current_user).novistos.limit(10)
		respond_to do |format|
			format.html
			format.js
		end	
	end
	def update
		Notification.where("item_type = ? and item_id = ?", @notification.item_type, @notification.item_id).update(viewed:true)
		redirect_to controller: "#{@notification.item_type.downcase}s", action: 'show', id: "#{@notification.item_id}"
	end

	private
	def set_notification
		@notification = Notification.find(params[:id])
	end
end