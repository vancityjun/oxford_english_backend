module Types
  class VocabularyType < Types::BaseObject
    field :id, ID, null: false
    field :word, String, null: false
    field :level, String, null: true
    field :pos, String, null: true
    field :ox5000, Boolean, null: true
  end
end
