module Types
  class QueryType < Types::BaseObject
    field :vocabularies, VocabularyType.connection_type, null: false do
      argument :levels, [String, { null: true }], required: false
      argument :has_note, Boolean, required: false
      argument :order, String, required: false
    end
    def vocabularies(levels:, order: nil, has_note: nil)
      levels = %w[a1 a2 b1 b2 c1 c2] if levels.empty?
      extra = {}
      current_user_id = context[:current_user].try(:id)
      extra[:notes] = { user_id: current_user_id } if has_note && current_user_id

      Vocabulary.includes(:notes)
                .where(**extra, level: levels)
                .order(order.to_s)
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
