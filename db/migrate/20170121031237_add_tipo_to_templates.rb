class AddTipoToTemplates < ActiveRecord::Migration[5.0]
  def change
    add_column :templates, :tipo, :string
  end
end
