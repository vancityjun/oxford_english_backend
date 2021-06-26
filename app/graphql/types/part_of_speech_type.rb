module Types
  class PartOfSpeechType < Types::BaseObject
    field :label, String, null: false
    field :value, String, null: false
  end
end
