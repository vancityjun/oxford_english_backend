module Mutations
  class Register < Mutations::BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true
    argument :first_name, String, required: true
    argument :last_name, String, required: true

    field :errors, [String], null: true
    field :user, Types::UserType, null: false

    def resolve(email:, password:, first_name:, last_name:)
      user = User.new(email: email, password: password, first_name: first_name, last_name: last_name)

      if user.save!
        context[:current_user] = user
        {
          user: user,
          errors: []
        }
      else
        {
          errors: ['register failed']
        }
      end
    end
  end
end
