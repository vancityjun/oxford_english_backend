FactoryBot.define do
  factory :definition do
    sequence(:content) { |n| "definition #{n}"}
    like {32}
    dislike {6}
    language_code {'en'}
    examples {build_list :example, 3}
  end
end
