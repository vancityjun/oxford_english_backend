FactoryBot.define do
  factory :vocabulary do
    word {'abandon'}
    level {'b1'}
    pos {'verb'}
    user {association :user}
  end
end
