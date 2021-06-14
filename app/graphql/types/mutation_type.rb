module Types
  class MutationType < Types::BaseObject
    field :register, mutation: Mutations::Register
    field :login, mutation: Mutations::Login
    field :create_definition, mutation: Mutations::CreateDefinition
    field :update_definition, mutation: Mutations::UpdateDefinition
    field :delete_definition, mutation: Mutations::DeleteDefinition
    field :update_user, mutation: Mutations::UpdateUser
    field :delete_user, mutation: Mutations::DeleteUser
    field :add_vocabulary, mutation: Mutations::AddVocabulary
  end
end
