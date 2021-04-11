module Types
  class BaseInputObject < GraphQL::Schema::InputObject
    argument_class Types::BaseArgument
  end

  class ExampleAttributes < Types::BaseInputObject
    argument :id, ID, required: false
    argument :content, String, required: false
    argument :_destroy, Boolean, required: false
  end

  class DefinitionAttributes < Types::BaseInputObject
    argument :content, String, required: true
    argument :form, String, required: false
    argument :language_code, String, required: true
  end

  class UserAttributes < Types::BaseInputObject
    argument :email, String, required: false
    argument :first_name, String, required: false
    argument :last_name, String, required: false
  end
end
