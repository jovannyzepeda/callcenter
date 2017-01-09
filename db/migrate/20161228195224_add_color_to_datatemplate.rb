class AddColorToDatatemplate < ActiveRecord::Migration[5.0]
  def change
    add_column :datatemplates, :color, :string
  end
end
