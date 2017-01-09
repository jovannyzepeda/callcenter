class AddLeftwidthToDatatemplate < ActiveRecord::Migration[5.0]
  def change
    add_column :datatemplates, :left_width, :integer
  end
end
