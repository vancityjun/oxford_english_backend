FactoryBot.define do
  factory :definition do
    sequence(:content) { |n| "definition #{n}"}
    language_code {'en'}
    examples {build_list :example, 3}
  end
end
