module Types
  class NoteType < Types::BaseObject
    field :id, ID, null: false
    field :definitions, [Types::DefinitionType], null: true
    field :user_id, ID, null: false
    field :vocabulary_id, ID, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
