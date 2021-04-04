module Mutations
  class UpdateDefinition < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :definition_attributes, Types::DefinitionAttributes, required: true
    argument :examples, [Types::ExampleAttributes], required: false

    field :definition, Types::DefinitionType, null: false
    field :errors, [String], null: false

    def resolve(id:, definition_attributes:, examples:)
      return unless context[:current_user]

      definition = Definition.find(id)
      examples_attributes = examples.as_json(only: %i[id content _destroy])

      definition.update(**definition_attributes.to_h, examples_attributes: examples_attributes)

      if definition.save!
        {
          definition: definition,
          errors: []
        }
      else
        { errors: ['there was an error while updating definitions'] }
      end
    end
  end
end
