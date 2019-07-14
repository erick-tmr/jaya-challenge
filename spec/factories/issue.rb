FactoryBot.define do
  factory :issue do
    sequence(:github_id, (1..100000).to_a.shuffle.to_enum)
  end
end
