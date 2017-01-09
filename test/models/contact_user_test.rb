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

require 'test_helper'

class ContactUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
