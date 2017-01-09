# == Schema Information
#
# Table name: datatemplates
#
#  id          :integer          not null, primary key
#  template_id :integer
#  content     :text(65535)
#  width       :integer
#  height      :integer
#  fontsize    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  left_width  :integer
#  color       :string(255)
#

class Datatemplate < ApplicationRecord
  belongs_to :template
end
