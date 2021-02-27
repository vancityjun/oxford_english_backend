module Types
  class QueryType < Types::BaseObject

    field :vocabularies, VocabularyType.connection_type, null: false do
      argument :levels, [String, null: true], required: false
    end
    def vocabularies(levels:)
      return Vocabulary.all if levels.empty?
      Vocabulary.where level: levels
    end
  end
end
