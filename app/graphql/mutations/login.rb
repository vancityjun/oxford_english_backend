module Mutations
  class Login < Mutations::BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :errors, [String], null: true
    field :user, Types::UserType, null: false

    def resolve(email:, password:)
      user = User.find_by(email: email)
      
      if user && user.password === password
        context[:session][:token] = token
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
