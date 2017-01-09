# == Schema Information
#
# Table name: notifications
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  item_type  :string(255)
#  item_id    :integer
#  viewed     :boolean          default("0")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  content    :string(255)
#

class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :item, polymorphic: true
  after_create { NotificationBroadcastJob.perform_later(self)}
  scope :novistos, -> {where(viewed:false).order(created_at: :desc)}

  private
  def self.for_user(user)
  	Notification.where(user_id:user).novistos.count
  end
end
