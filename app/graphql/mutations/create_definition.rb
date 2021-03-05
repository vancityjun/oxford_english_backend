module Mutations
  class CreateDefinition < Mutations::BaseMutation
    argument :vocabulary_id, ID, required: true
    argument :content, String, required: true
    argument :form, String, required: true

    field :definition, Types::DefinitionType, null: true
    field :errors, [String], null: false

    def resolve(body:, vocabulary_id:)
      vocabulary = Vocabulary.find(vocabulary_id)
      definition = vocabulary.definitions.build(content: content)
    end
  end
end
