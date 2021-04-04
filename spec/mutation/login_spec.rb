require 'rails_helper'

RSpec.describe Mutations::Login, type: :request do
  let!(:user) {create :user}

  it 'creates definition with examples' do
    query = <<-GQL
      mutation login ($input: LoginInput!) {
        login (input: $input){
            user{
              token
              id
              email
              lastName
              firstName
            }
          }        
      }
    GQL

    variables = {
      email: 'jun@example.com',
      password: '1234'
    }
    result = ServerSchema.execute(
      query,
      variables: {input: variables},
    ).to_h.deep_symbolize_keys[:data][:login]

    expect(result[:user]).to match({
      id: user.id.to_s,
      token: kind_of(String),
      email: user.email,
      lastName: user.last_name,
      firstName: user.first_name
    })
  end
end