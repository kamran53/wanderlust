FactoryBot.define do
  factory :project_manager do
    sequence(:name) { |n| "PM #{n}" }
    sequence(:email) { |n| "pm#{n}@example.com" }
  end
end 