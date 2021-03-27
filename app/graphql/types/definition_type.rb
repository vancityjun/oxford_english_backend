module Types
  class DefinitionType < Types::BaseObject
    field :id, ID, null: false
    field :content, String, null: false
    field :form, String, null: true
    field :language_code, String, null: true
    field :note_id, ID, null: false
    field :examples, [Types::ExampleType], null: true
    field :user, Types::UserType, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    def user
      object.note.user
    end
  end
end
