FactoryBot.define do
  factory :video do
    association :project
    association :video_type
  end
end 