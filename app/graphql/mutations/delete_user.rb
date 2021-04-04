module Mutations
  class DeleteUser < Mutations::BaseMutation
    argument :password, String, required: true

    field :errors, [String], null: false
    field :message, String, null: false

    def resolve(password:)
      user = context[:current_user]
      return unless user && user.password == password

      if user.destroy!
        {
          message: 'Successfully deleted',
          errors: []
        }
      else
        { errors: ['there was an error while deleting user'] }
      end
    end
  end
end
