# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  rol                    :string(255)
#  nombre                 :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  meta                   :float(24)
#  privilegio             :integer
#  status                 :integer
#  number                 :integer
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
   	include PermissionsConcern
   	include FunctionsConcern
   	has_many :usergroup
	  has_many :groups, through: :usergroup
    has_many :contacts, through: :contact_user
    has_many :contact_user
    has_many :contracts
    has_many :usercompany
    has_many :companys, through: :usercompany
	def self.update_number(user,number)
		usuario = User.find(user.id)
		usuario.update(number: number)
	end
  def self.last_active
    User.where("status = 1").order(:number).first
  end
  def self.active
    User.where("status = 1")
  end
  def notifications_count
    Notification.for_user(self.id)
  end
end
