FactoryBot.define do
  factory :client do
    sequence(:name) { |n| "Client #{n} #{Time.now.to_i}" }
    sequence(:email) { |n| "client#{n}#{Time.now.to_i}@examples.com" }
  end
end
