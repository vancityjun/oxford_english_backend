module Mutations
  class AddVocabulary < Mutations::BaseMutation
    argument :word, String, required: true
    argument :pos, String, required: true
    argument :celpip, Boolean, required: false
    argument :level, String, required: false

    argument :definition_attributes, Types::DefinitionAttributes, required: false
    argument :examples, [Types::ExampleAttributes], required: false

    field :vocabulary, Types::VocabularyType, null: false
    field :errors, [String], null: false

    def resolve(word:, pos:, celpip: false, level: nil, definition_attributes:, examples: [])
      current_user = context[:current_user]
      return unless current_user.admin

      vocabulary =  Vocabulary.find_or_initialize_by(word: word, pos: pos)
      vocabulary.celpip = celpip
      vocabulary.level = level if vocabulary.new_record? && level.present?

      result = ActiveRecord::Base.transaction do

        current_user.vocabularies << vocabulary if current_user.vocabularies.find_by_id(vocabulary.id).nil?
        note = Note.find_by(user_id: current_user.id, vocabulary_id: vocabulary.id)
  
        definition = note.definitions.build(definition_attributes.to_h)
        definition.form = pos
  
        examples.each do |example|
          definition.examples.build(content: example[:content]) if example[:content].present?
        end
        note.save!
      end

      if result
        {
          vocabulary: vocabulary,
          errors: []
        }
      else
        { errors: ['there was an error while adding vocabulary'] }
      end
    end
  end
end
