module Types
  class VocabularyType < Types::BaseObject
    field :id, ID, null: false
    field :word, String, null: false
    field :level, String, null: true
    field :pos, String, null: true
    field :ox5000, Boolean, null: true
    field :definitions, Types::DefinitionType.connection_type, null: true
    field :note, Types::NoteType, null: true
    def note
      @object.notes.find_by(user_id: context[:current_user].id)
    end
  end
end
