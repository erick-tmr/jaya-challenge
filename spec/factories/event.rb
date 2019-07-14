FactoryBot.define do
  factory :event do
    action { 'created' }
    payload { { something: 'here' } }

    issue
  end
end
