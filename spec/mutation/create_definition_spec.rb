require 'rails_helper'

RSpec.describe Mutations::CreateDefinition, type: :request do
  let!(:user) {create :user}
  let!(:vocabulary) {create :vocabulary}

  it 'creates definition with examples' do
    query = <<-GQL
      mutation createDefinition($input: CreateDefinitionInput!) {
        createDefinition(input: $input) {
          definition{
            content
            form
            languageCode
            examples{
              content
            }
          }
          errors
        }
      }
    GQL

    variables = {
      vocabularyId: vocabulary.id,
      definitionAttributes: {
        content: "to leave somebody, especially somebody you are responsible for, with no intention of returning",
        form: nil,
        languageCode: 'en',
      },
      examples: [
        {content: "The baby had been abandoned by its mother."},
        {content: "People often simply abandon their pets when they go abroad."}
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
    # created_definition = vocabulary.definitions.last
    # expect(result[:definition]).to match({
    #   content: created_definition.content,
    #   form: created_definition.form,
    #   languageCode: created_definition.language_code,
    #   examples: examples(created_definition.examples)
    # })
  end

  def examples(examples)
    examples.map do |example|
      { content: example.content }
    end
  end
end