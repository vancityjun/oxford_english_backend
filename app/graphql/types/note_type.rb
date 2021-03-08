module Types
  class NoteType < Types::BaseObject
    field :id, ID, null: false
    field :definitions, [Types::DefinitionType], null: true
    field :user_id, ID, null: false
    field :vocabulary_id, ID, null: false
  end
end
