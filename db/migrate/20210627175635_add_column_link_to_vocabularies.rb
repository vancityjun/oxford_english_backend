class AddColumnLinkToVocabularies < ActiveRecord::Migration[6.1]
  def change
    add_column :vocabularies, :link, :string
  end
end
