# == Schema Information
#
# Table name: contacts
#
#  id          :integer          not null, primary key
#  cliente     :string(255)
#  telefono    :string(255)
#  campaign_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  status      :string(255)
#

require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
