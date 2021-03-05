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

    field :definitions, DefinitionType.connection_type, null: false do
      argument :vocabulary_id, Integer, required: true
    end
    def definitions(vocabulary_id:)
      Definition.where vocabulary_id: vocabulary_id
    end
  end
end
