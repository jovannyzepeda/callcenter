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
#  date_close  :date
#  eliminado   :boolean          default("0")
#  fax         :string(255)
#  correo      :string(255)
#  city        :string(255)
#  country     :string(255)
#  unit_size   :string(255)
#  season      :string(255)
#  resort      :string(255)
#

require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
