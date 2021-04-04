require 'rails_helper'

RSpec.describe Mutations::UpdateUser, type: :request do
  let!(:user) {create :user}
  let(:query) {
    <<-GQL
      mutation updateUser ($input: UpdateUserInput!) {
        updateUser (input: $input){
          user{
            token
            id
            userAttributes {
              email
              lastName
              firstName
            }
          }
        }
      }
    GQL
  }

  it 'update user' do
    variables = {
      userAttributes: {
        email: 'joker@example.com',
        firstName: 'Joker',
        lastName: 'Aurthor',
      }
    }

    expect do
      result = ServerSchema.execute(
        query,
        variables: {input: variables},
        context: {current_user: user}
      ).to_h.deep_symbolize_keys[:data][:updateUser]

      expect(result[:user]).to match({
        id: user.id.to_s,
        token: kind_of(String),
        userAttributes: variables[:userAttributes]
      })
    end.to_not change(user, :password)
  end

  context 'changing password' do
    it 'update password' do
      variables = {
        userAttributes: {
          password: '4321'
        },
        password: '1234'
      }
      expect do
        result = ServerSchema.execute(
          query,
          variables: {input: variables},
          context: {current_user: user}
        ).to_h.deep_symbolize_keys[:data][:updateUser]

        expect(result[:user]).to match({
          id: user.id.to_s,
          token: kind_of(String),
          userAttributes: {
            email: user.email,
            lastName: user.last_name,
            firstName: user.first_name            
          }
        })
      end.to change(user, :password).from('1234').to('4321')
    end  
  end
end
