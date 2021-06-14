require 'rails_helper'

RSpec.describe Types::UserType, type: :request do
  let!(:user) {create :user}

  it 'returns user' do
    query = <<-GQL
      query {
        currentUser{
          id
          userAttributes{
            email
            firstName
            lastName
          }
          fullName
          token
          admin
        }
      }
    GQL

    result = ServerSchema.execute(
      query,
      context: {current_user: user}
    ).to_h.deep_symbolize_keys[:data][:currentUser]

    expect(result).to match({
      id: user.id.to_s,
      userAttributes: {
        email: user.email,
        firstName: user.first_name,
        lastName: user.last_name,
      },
      fullName: "#{user.first_name} #{user.last_name}",
      token: user.token,
      admin: user.admin
    })
  end
end
