require 'rails_helper'

RSpec.describe Mutations::UpdateDefinition do
  let!(:user) {create :user}
  let!(:definition) {create :definition}
  let(:example_ids) {definition.examples.pluck(:id)}

  it 'update definition' do
    query = <<-GQL
      mutation updateDefinition($input: UpdateDefinitionInput!) {
        updateDefinition(input: $input) {
          definition{
            id
            content
            languageCode
            form
            examples{
              id
              content
            }
          }
        }
      }
    GQL

    variables = {
      id: definition.id,
      definitionAttributes: {
        content: "to leave somebody, especially somebody you are responsible for, with no intention of returning",
        form: nil,
        languageCode: 'en'
      },
      examples: [
        {
          id: example_ids[0],
          _destroy: true
        },
        {
          id: example_ids[1],
          content: "The baby had been abandoned by its mother."
        },
        {
          id: example_ids[2],
          content: ''
        }
      ]
    }
    result = nil
    expect do
      result = ServerSchema.execute(
        query,
        variables: {input: variables},
        context: {current_user: user}
      ).to_h.deep_symbolize_keys[:data][:updateDefinition]
    end.
      to change {definition.reload.examples.count}.by(-1)

    expect(result[:definition]).to match({
      id: definition.id.to_s,
      content: definition.content,
      form: definition.form,
      languageCode: definition.language_code,
      examples: examples(definition.examples)
    })
  end
  def examples(examples)
    examples.map do |example|
      { 
        id: example.id.to_s,
        content: example.content 
      }
    end
  end
end
