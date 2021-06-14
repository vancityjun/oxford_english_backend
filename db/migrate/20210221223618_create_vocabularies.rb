class CreateVocabularies < ActiveRecord::Migration[6.1]
  def change
    create_table :vocabularies do |t|
      t.string :word
      t.string :level
      t.string :pos
      t.boolean :ox5000, default: false
      t.boolean :celpip, default: false

      t.timestamps
    end
  end
end
