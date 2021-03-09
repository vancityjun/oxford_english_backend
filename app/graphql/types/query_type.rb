module Types
  class QueryType < Types::BaseObject

    field :vocabularies, [VocabularyType], null: false do
      argument :levels, [String, null: true], required: false
    end
    def vocabularies(levels:)
      return Vocabulary.all if levels.empty?
      Vocabulary.where level: levels
    end

    field :current_user, UserType, null: false
    def current_user
      context[:current_user]
    end

    field :note, NoteType, null: false do
      argument :user_id, Integer, required: false
      argument :vocabulary_id, Integer, required: true
    end
    def note(user_id:, vocabulary_id:)
      Note.where(user_id: user_id, vocabulary_id: vocabulary_id)
    end

    field :definitions, Types::DefinitionType.connection_type, null: false do
      argument :vocabulary_id, Integer, required: true
    end
    def definitions(vocabulary_id:)
      vocabulary = Vocabulary.find(vocabulary_id)
      vocabulary.notes.map(&:definitions).flatten
    end
  end
end
