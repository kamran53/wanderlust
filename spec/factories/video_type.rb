FactoryBot.define do
  factory :video_type do
    sequence(:name) { |n| "VideoType #{n} #{Time.now.to_i}" }
    price { 1000 }
  end
end 