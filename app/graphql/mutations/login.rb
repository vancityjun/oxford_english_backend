module Mutations
  class Login < Mutations::BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :errors, [String], null: true
    field :user, Types::UserType, null: true

    def resolve(email:, password:)
      user = User.find_by(email: email.downcase)
      errors = []
      if user.blank?
        errors << 'User not found'
      elsif user.password != password
        errors << 'Incorrect password'
        user = nil
      end
      context[:current_user] = user
      {
        user: user,
        errors: errors
      }
    end
  end
end
