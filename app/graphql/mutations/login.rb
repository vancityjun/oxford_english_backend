module Mutations
  class Login < Mutations::BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :errors, [String], null: true
    field :user, Types::UserType, null: true

    def resolve(email:, password:)
      user = User.find_by(email: email)
      
      if user && user.password === password
        context[:current_user] = user
        {
          user: user,
          errors: []
        }
      else
        {
          errors: ['incorrect account or password']
        }
      end
    end
  end
end
