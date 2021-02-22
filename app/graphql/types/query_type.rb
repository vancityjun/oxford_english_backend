module Types
  class QueryType < Types::BaseObject

    field :vocabularies, VocabularyType.connection_type, null: false do
      argument :level, String, required: false
    end
    def vocabularies(level:)
      return Vocabulary.all unless level
      Vocabulary.where level: level
    end
  end
end
