require 'rails_helper'

RSpec.describe Mutations::DeleteUser, type: :request do
  let!(:user) {create :user}

  it 'delete user' do
    query = <<-GQL
      mutation deleteUser ($input: DeleteUserInput!) {
        deleteUser (input: $input){
          message
        }
      }
    GQL

    variables = {
      password: '1234'
    }
    expect do
      result = ServerSchema.execute(
        query,
        variables: {input: variables},
        context: {current_user: user}
      ).to_h.deep_symbolize_keys[:data][:deleteUser]

      expect(result[:message]).to eq('Successfully deleted')
    end.to change(User, :count).by(-1)

  end
end