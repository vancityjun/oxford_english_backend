FactoryBot.define do
  factory :example do
    sequence(:content) { |n| "example #{n}"}
  end
end
