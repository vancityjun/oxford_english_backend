class CreateExamples < ActiveRecord::Migration[6.1]
  def change
    create_table :examples do |t|
      t.belongs_to :definitions
      t.text :content

      t.timestamps
    end
  end
end
