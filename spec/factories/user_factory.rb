FactoryBot.define do
  factory :user do
    email {'jun@example.com'}
    last_name {'Jun'}
    first_name {'Jun'}
    vocabularies {[association(:vocabulary)]}
  end
end
