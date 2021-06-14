module Types
  class VocabularyType < Types::BaseObject
    field :id, ID, null: false
    field :word, String, null: false
    field :level, String, null: true
    field :pos, String, null: true
    field :ox5000, Boolean, null: true
    field :celpip, Boolean, null: true
    field :note, Types::NoteType, null: true
    def note
      object.notes.find { |note| note.user_id == context[:current_user].try(:id) }
    end
  end
end
