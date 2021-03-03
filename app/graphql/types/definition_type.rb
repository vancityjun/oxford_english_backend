module Types
  class DefinitionType < Types::BaseObject
    field :id, ID, null: false
    field :definition, String, null: false
    field :form, String, null: false
  end
end
