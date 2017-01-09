# == Schema Information
#
# Table name: campaigns
#
#  id         :integer          not null, primary key
#  nombre     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :integer
#

require 'test_helper'

class CampaignTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
