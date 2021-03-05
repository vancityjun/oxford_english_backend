module Mutations
  class Register < Mutations::BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true
    argument :first_name, String, required: true
    argument :last_name, String, required: true

    field :errors, [String], null: true
    field :token, String, null: false
    field :user, Types::UserType, null: false

    def resolve(email:, password:, first_name:, last_name:)
      email.downcase if email =~ /[A-Z]/
      user = User.new(email: email, password: password, first_name: first_name, last_name: last_name)
      
      if user.save
        token = JWT.encode(user.id.to_s, nil, 'none')
        user.delete if token.nil?
        context[:session][:token] = token
        {
          token: token,
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
