class CreateNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :notes do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :vocabulary, index: true, foreign_key: true

      t.timestamps
    end
  end
end
