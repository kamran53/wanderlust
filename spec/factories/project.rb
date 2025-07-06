FactoryBot.define do
  factory :project do
    association :client
    association :project_manager
    name { "Test Project" }
    status { "pending" }
    raw_footage_link { "http://example.com/raw.mp4" }
  end
end 