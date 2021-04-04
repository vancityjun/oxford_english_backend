require 'rails_helper'

RSpec.describe Mutations::UpdateDefinition do
  let!(:user) {create :user}
  let!(:vocabulary) {create :vocabulary}
  let!(:definition) {create :definition}
  let(:note) {Note.create(definitions: [definition], user: user, vocabulary: vocabulary)}
  let(:query) {
    <<-GQL
      mutation deleteDefinition($input: DeleteDefinitionInput!) {
        deleteDefinition(input: $input) {
          message
        }
      }
    GQL
  }

  it 'delete definition' do
    note.reload
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
      to change(Definition, :count).by(-1).
      and change(Note, :count).by(-1)

    expect(result[:message]).to eq('Successfully deleted')
  end

  context 'if any of definition is remain' do
    let(:definition2) {create :definition}
    it 'remove the particular definition and not remove the note' do
      note.definitions << definition2

      variables = {
        id: definition2.id
      }
      expect do
        result = ServerSchema.execute(
          query,
          variables: {input: variables},
          context: {current_user: user}
        ).to_h.deep_symbolize_keys[:data][:deleteDefinition]

        expect(result[:message]).to eq('Successfully deleted')
      end.
        to change(Definition, :count).by(-1).
        and change(Note, :count).by(0)
  
    end
  end
end