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

require 'test_helper'

class UsercompanyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
