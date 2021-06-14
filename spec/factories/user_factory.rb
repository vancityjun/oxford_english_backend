FactoryBot.define do
  factory :user do
    email {'jun@example.com'}
    last_name {'Lee'}
    first_name {'Jun'}
    password {'1234'}
    admin {true}
    trait :with_vocabulary do
      vocabularies {[association(:vocabulary)]}
    end
  end
end
