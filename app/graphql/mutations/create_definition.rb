module Mutations
  class CreateDefinition < Mutations::BaseMutation
    argument :vocabulary_id, ID, required: true
    argument :content, String, required: true
    argument :form, String, required: false
    argument :examples, [Types::ExampleAttributes], required: false

    field :definition, Types::DefinitionType, null: false
    field :errors, [String], null: false

    def resolve(vocabulary_id:, content:, form:, examples:)
      vocabulary = Vocabulary.find(vocabulary_id)
      current_user = context[:current_user]

      current_user.vocabularies << vocabulary if current_user.vocabularies.find_by_id(vocabulary_id).nil?
      note = Note.find_by(user_id: current_user.id, vocabulary_id: vocabulary_id)

      definition = note.definitions.build(content: content, form: form)

      examples.each do |example|
        definition.examples.build(content: example[:content]) if example[:content].present?
      end

      if note.save!
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
