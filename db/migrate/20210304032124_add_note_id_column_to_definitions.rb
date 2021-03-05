class AddNoteIdColumnToDefinitions < ActiveRecord::Migration[6.1]
  def change
    add_belongs_to :definitions, :notes, index: true, foreign_key: true
  end
end
