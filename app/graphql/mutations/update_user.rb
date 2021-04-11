module Mutations
  class UpdateUser < Mutations::BaseMutation
    argument :user_attributes, Types::UserAttributes, required: true
    argument :password, String, required: false
    argument :new_password, String, required: false

    field :user, Types::UserType, null: false
    field :errors, [String], null: false
    field :message, String, null: true

    def resolve(user_attributes:, password: nil, new_password: nil)
      user = context[:current_user]
      return if user.blank?

      error_message = 'There was an error while updating user'

      user_attributes = user_attributes.to_h
      message = 'Successfully updated!'

      if new_password.present?
        error_message = 'Password is incorrect' if user.password != password
        user.update_attribute(password: new_password)
      end

      user.update(user_attributes.to_h)

      if user.save!
        {
          user: user,
          message: message,
          errors: []
        }
      else
        { errors: [error_message] }
      end
    end
  end
end
