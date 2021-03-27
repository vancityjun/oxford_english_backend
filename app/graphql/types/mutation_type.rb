module Types
  class MutationType < Types::BaseObject
    field :register, mutation: Mutations::Register
    field :login, mutation: Mutations::Login
    field :create_definition, mutation: Mutations::CreateDefinition
    field :update_definition, mutation: Mutations::UpdateDefinition
    field :delete_definition, mutation: Mutations::DeleteDefinition
  end
end
