require 'rails_helper'

RSpec.describe Mutations::UpdateDefinition do
  let!(:user) {create :user}
  let!(:definition) {create :definition}

  it 'update definition' do
    query = <<-GQL
      mutation deleteDefinition($input: DeleteDefinitionInput!) {
        deleteDefinition(input: $input) {
          message
        }
      }
    GQL

    variables = {
      id: definition.id
    }
    result = nil
    expect do
      result = ServerSchema.execute(
        query,
        variables: {input: variables},
        context: {current_user: user}
      ).to_h.deep_symbolize_keys[:data][:deleteDefinition]
    end.
      to change {Definition.count}.by(-1)

    expect(result[:message]).to eq('Successfully deleted')
  end
end