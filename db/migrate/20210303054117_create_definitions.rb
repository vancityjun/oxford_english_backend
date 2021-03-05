class CreateDefinitions < ActiveRecord::Migration[6.1]
  def change
    create_table :definitions do |t|
      t.text :content
      t.string :form
      t.timestamps
    end
  end
end
