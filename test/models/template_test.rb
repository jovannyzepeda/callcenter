# == Schema Information
#
# Table name: templates
#
#  id                     :integer          not null, primary key
#  company_id             :integer
#  lenguaje               :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  papermate_file_name    :string(255)
#  papermate_content_type :string(255)
#  papermate_file_size    :integer
#  papermate_updated_at   :datetime
#

require 'test_helper'

class TemplateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
