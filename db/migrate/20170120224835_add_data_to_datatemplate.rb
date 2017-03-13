class AddDataToDatatemplate < ActiveRecord::Migration[5.0]
  def change
    add_column :datatemplates, :bold, :string
    add_column :datatemplates, :text_align, :string
  end
end
