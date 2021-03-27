class AddColumnsToDefinitions < ActiveRecord::Migration[6.1]
  def change
    add_column :definitions, :language_code, :string
  end
end
