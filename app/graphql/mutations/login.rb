module Mutations
  class Login < Mutations::BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :errors, [String], null: true
    field :token, String, null: false
    field :user, Types::UserType, null: false

    def resolve(email:, password:)
      email.downcase if email =~ /[A-Z]/
      user = User.find_by(email: email)
      
      if user && user.password === password
        token = JWT.encode(user.id.to_s, nil, 'none')
        context[:session][:token] = token
        {
          token: token,
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
