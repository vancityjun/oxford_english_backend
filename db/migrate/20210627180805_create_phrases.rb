class CreatePhrases < ActiveRecord::Migration[6.1]
  def change
    create_table :phrases do |t|
      t.string :word
      t.string :level
      t.string :link

      t.timestamps
    end
  end
end
