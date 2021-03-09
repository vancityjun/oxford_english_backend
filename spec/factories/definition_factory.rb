FactoryBot.define do
  factory :definition do
    sequence(:content) { |n| "definition #{n}"}
    examples {build_list :example, 3}
  end
end
