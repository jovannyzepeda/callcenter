# == Schema Information
#
# Table name: companies
#
#  id                :integer          not null, primary key
#  nombre            :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  logo_file_name    :string(255)
#  logo_content_type :string(255)
#  logo_file_size    :integer
#  logo_updated_at   :datetime
#

require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
