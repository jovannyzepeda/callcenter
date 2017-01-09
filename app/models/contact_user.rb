# == Schema Information
#
# Table name: contact_users
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  contact_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ContactUser < ApplicationRecord
  belongs_to :user
  belongs_to :contact

  private
  	def self.save_data(user,contact)
  		cu = ContactUser.new(user_id: user.id, contact_id: contact.id)
  		cu.save
  	end
  	def self.update_data(user_id,contact_id, new_user_id)
  		cu = ContactUser.where("user_id = ? and contact_id = ?", user_id, contact_id).first
  		cu.user_id = new_user_id
  		cu.save
  	end
end
