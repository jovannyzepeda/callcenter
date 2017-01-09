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

require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
