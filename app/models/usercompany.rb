# == Schema Information
#
# Table name: usercompanies
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  company_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Usercompany < ApplicationRecord
  belongs_to :user
  belongs_to :company
end
