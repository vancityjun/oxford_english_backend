module Mutations
  class UpdateUser < Mutations::BaseMutation
    argument :user_attributes, Types::UserAttributes, required: true
    argument :password, String, required: false

    field :user, Types::UserType, null: false
    field :errors, [String], null: false

    def resolve( user_attributes:, password: nil)
      user = context[:current_user]
      return unless user
      return if user_attributes.try(:password).present? && user.password != password

      user.update(user_attributes.to_h)

      if user.save!
        {
          user: user,
          errors: []
        }
      else
        { errors: ['there was an error while updating user'] }
      end
    end
  end
end
