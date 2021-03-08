require 'rails_helper'

RSpec.describe Mutations::CreateDefinition, type: :request do
  let!(:user) {create :user}
  let!(:vocabulary) {create :vocabulary}

  it 'creates definition with examples' do
    query = <<-GQL
      mutation createDefinition($input: CreateDefinitionInput!) {
        createDefinition(input: $input) {
          vocabulary {
            id
            word
            level
            pos
            ox5000
            note {
              definitions{
                content
                examples{
                  content
                }
              }
            }
          }
          errors
        }
      }
    GQL

    variables = {
      vocabularyId: vocabulary.id,
      content: "to leave somebody, especially somebody you are responsible for, with no intention of returning",
      form: nil,
      examples: [
        "The baby had been abandoned by its mother.",
        "People often simply abandon their pets when they go abroad."
      ]
    }
    result = nil
    expect do
      result = ServerSchema.execute(
        query,
        variables: {input: variables},
        context: {current_user: user}
      ).to_h.deep_symbolize_keys[:data][:createDefinition]
    end.
      to change {Example.count}.by(2).
      and change {Definition.count}.by(1).
      and change {Note.count}.by(1)

    expect(result[:errors]).to be_empty
    expect(result[:vocabulary]).to match({
      id: vocabulary.id.to_s,
      word: vocabulary.word,
      level: vocabulary.level,
      pos: vocabulary.pos,
      ox5000: vocabulary.ox5000,
      note: {
        definitions: definitions(Note.last.definitions)
      }
    })
  end

  def definitions(definitions)
    definitions.map do |definition|
      {
        content: definition.content,
        examples: examples(definition.examples)
      }
    end
  end
  def examples(examples)
    examples.map do |example|
      { content: example.content }
    end
  end
end