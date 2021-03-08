module Types
  class DefinitionType < Types::BaseObject
    field :id, ID, null: false
    field :content, String, null: false
    field :form, String, null: false
    field :note_id, ID, null: false
    field :examples, [Types::ExampleType], null: true
  end
end
