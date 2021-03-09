module Mutations
  class Logout < Mutations::BaseMutation
    field :errors, [String], null: true
    field :message, String, null: false

    def resolve
      context[:session][:token] = nil
      {
        message: 'user logout',
        errors: []
      }
    end
  end
end
