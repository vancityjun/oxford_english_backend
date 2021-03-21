require 'rails_helper'

RSpec.describe Types::VocabularyType, type: :request do
  let!(:vocabulary) {create :vocabulary}
  let!(:user) {create :user, vocabularies: [vocabulary]}
  let(:note) {Note.find_by(user_id: user.id, vocabulary_id: vocabulary.id)}
  let(:definitions) {create_list :definition, 3}

  it 'returns vocabularies with definitions' do
    note.definitions << definitions
    note.save!

    query = <<-GQL
      query($first: Int, $levels: [String]) {
        vocabularies (first: $first,levels: $levels) {
          totalCount
          edges{
            cursor
            node{
              id
              word
              pos
              level
              ox5000
              count
              note {
                updatedAt
                definitions {
                  content
                  form
                  examples {
                    content
                  }
                }
              }
            }
          }
        }
      }
    GQL

    result = ServerSchema.execute(
      query,
      variables: {first: 1, levels: ['b1']},
      context: {current_user: user}
    ).to_h.deep_symbolize_keys[:data][:vocabularies][:edges]
    
    expect(result[0][:node]).to match({
      id: vocabulary.id.to_s,
      word: vocabulary.word,
      level: vocabulary.level,
      pos: vocabulary.pos,
      ox5000: vocabulary.ox5000,
      count: 1,
      note: {
        updatedAt: kind_of(String),
        definitions: definitions_attr(definitions)
      }
    })
  end

  def definitions_attr(definitions)
    definitions.map do |definition|
      {
        content: definition.content,
        examples: examples(definition.examples),
        form: definition.form
      }
    end
  end
  def examples(examples)
    examples.map do |example|
      { content: example.content }
    end
  end
end
