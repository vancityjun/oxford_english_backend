FactoryBot.define do
  factory :user do
    email {'jun@example.com'}
    last_name {'Lee'}
    first_name {'Jun'}
    vocabularies {[association(:vocabulary)]}
    password {'1234'}
  end
end
