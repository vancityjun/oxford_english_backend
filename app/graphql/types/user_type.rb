module Types
  class AttributesType < Types::BaseObject
    field :email, String, null: false
    field :first_name, String, null: false
    field :last_name, String, null: false
  end

  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :full_name, String, null: false
    field :token, String, null: false
    field :user_attributes, Types::AttributesType, null: false
    def user_attributes
      object
    end
  end
end
