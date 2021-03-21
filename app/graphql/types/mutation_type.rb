module Types
  class MutationType < Types::BaseObject
    field :register, mutation: Mutations::Register
    field :login, mutation: Mutations::Login
    field :logout, mutation: Mutations::Logout
    field :create_definition, mutation: Mutations::CreateDefinition
    field :update_definition, mutation: Mutations::UpdateDefinition
  end
end
