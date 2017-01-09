# == Schema Information
#
# Table name: historycontacts
#
#  id                      :integer          not null, primary key
#  contact_id              :integer
#  user_id                 :integer
#  title                   :string(255)
#  content                 :text(65535)
#  email                   :string(255)
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  attachment_file_name    :string(255)
#  attachment_content_type :string(255)
#  attachment_file_size    :integer
#  attachment_updated_at   :datetime
#

require 'test_helper'

class HistorycontactTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
