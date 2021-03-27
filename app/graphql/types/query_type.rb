module Types
  class QueryType < Types::BaseObject
    field :vocabularies, VocabularyType.connection_type, null: false do
      argument :levels, [String, { null: true }], required: false
    end
    def vocabularies(levels:)
      return Vocabulary.all.includes(:notes) if levels.empty?

      Vocabulary.where(level: levels).includes(:notes)
    end

    field :current_user, UserType, null: true
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

    field :definitions, DefinitionType.connection_type, null: false do
      argument :vocabulary_id, Integer, required: true
    end
    def definitions(vocabulary_id:)
      notes = Note.where(vocabulary_id: vocabulary_id).includes(definitions: :examples)
      notes.map(&:definitions).flatten
    end
  end
end
