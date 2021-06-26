require 'rails_helper'

RSpec.describe Types::VocabularyType, type: :request do
  let!(:vocabulary) {create :vocabulary}
  let!(:user) {create :user, vocabularies: [vocabulary]}
  let(:note) {Note.find_by(user_id: user.id, vocabulary_id: vocabulary.id)}
  let(:definitions) {create_list :definition, 3}
  let!(:query) do
    <<-GQL
      query(
          $first: Int,
          $last: Int,
          $levels: [String],
          $after: String,
          $before: String,
          $hasNote: Boolean
          $order: String
          $keyword: String
        ) {
        vocabularies (
          first: $first,
          last: $last,
          before: $before,
          after: $after,
          levels: $levels,
          hasNote: $hasNote,
          order: $order,
          keyword: $keyword
        ) {
          totalCount
          edges{
            cursor
            node{
              id
              word
              pos
              level
              ox5000
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
  end

  it 'returns vocabularies with definitions',focus: true do
    note.definitions << definitions
    note.save!

    result = ServerSchema.execute(
      query,
      variables: {first: 1, levels: []},
      context: {current_user: user}
    ).to_h.deep_symbolize_keys[:data][:vocabularies][:edges]
    
    expect(result[0][:node]).to match({
      id: vocabulary.id.to_s,
      word: vocabulary.word,
      level: vocabulary.level,
      pos: vocabulary.pos,
      ox5000: vocabulary.ox5000,
      note: {
        updatedAt: kind_of(String),
        definitions: definitions_attr(definitions)
      }
    })
  end

  context 'search by keyword' do
    let!(:vocabulary) {create :vocabulary}
    let!(:vocabulary_2) {create :vocabulary, word: 'predict'}
    let!(:vocabulary_3) {create :vocabulary, word: 'infer'}
    it 'returns that keyword is included',focus: true do

      note.definitions << definitions
      note.save!
  
      result = ServerSchema.execute(
        query,
        variables: {keyword: 'aban'},
        context: {current_user: user}
      ).to_h.deep_symbolize_keys[:data][:vocabularies][:edges]
      
      expect(result.count).to be(1)
      expect(result[0][:node]).to match({
        id: vocabulary.id.to_s,
        word: vocabulary.word,
        level: vocabulary.level,
        pos: vocabulary.pos,
        ox5000: vocabulary.ox5000,
        note: kind_of(Hash)
      })  
    end
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
