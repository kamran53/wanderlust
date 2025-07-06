FactoryBot.define do
  factory :notification do
    association :project_manager
    association :project
    message { "Test notification message" }
    read_at { nil }
  end
end 