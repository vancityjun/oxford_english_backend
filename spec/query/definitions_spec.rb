require 'rails_helper'

RSpec.describe Types::DefinitionType, type: :request do
  let!(:vocabulary) {create :vocabulary}
  let!(:user) {create :user, vocabularies: [vocabulary]}
  let(:note) {Note.find_by(user_id: user.id, vocabulary_id: vocabulary.id)}
  let(:definitions) {create_list :definition, 3}

  it 'returns definitions' do
    note.definitions << definitions
    note.save!

    query = <<-GQL
      query( $vocabularyId: Int!) {
        definitions (vocabularyId: $vocabularyId) {
          edges {
            cursor
            node {
              form
              content
              examples {
                content
              }
            }
          }
        }
      }
    GQL

    result = ServerSchema.execute(
      query,
      variables: { vocabularyId: vocabulary.id },
      context: {current_user: user}
    ).to_h.deep_symbolize_keys[:data][:definitions]

    expect(result[:edges]).to match(edges_attr(definitions))
  end

  def edges_attr(definitions)
    definitions.map do |definition|
      {
        cursor: kind_of(String),
        node:{
          content: definition.content,
          form: definition.form,
          examples: examples(definition.examples)
        }
      }
    end
  end
  def examples(examples)
    examples.map do |example|
      { content: example.content }
    end
  end
end
