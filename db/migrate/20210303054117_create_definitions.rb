class CreateDefinitions < ActiveRecord::Migration[6.1]
  def change
    create_table :definitions do |t|
      t.text :definition
      t.belongs_to :vocabulary, index: true, foreign_key: true
      t.string :form
      t.timestamps
    end
  end
end
