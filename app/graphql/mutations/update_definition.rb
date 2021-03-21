module Mutations
  class UpdateDefinition < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :content, String, required: true
    argument :form, String, required: false
    argument :examples, [Types::ExampleAttributes], required: false

    field :definition, Types::DefinitionType, null: false
    field :errors, [String], null: false

    def resolve(id:, content:, form:, examples:)
      definition = Definition.find(id)
      current_user = context[:current_user]
      examples_attributes = examples.as_json(only: [:id, :content, :_destroy])

      definition.update(content: content, form: form, examples_attributes: examples_attributes)

      if definition.save!
        {
          definition: definition,
          errors: []
        }
      else
        { errors: ['there was an error while creating definitions'] }
      end
    end
  end
end
