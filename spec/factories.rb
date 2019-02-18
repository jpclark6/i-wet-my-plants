FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "Lisa#{n}"}
    oauth_token { Faker::String.random(10) }
    uid { Faker::Number.number(8) }
  end
  factory :garden do
    association :user
    sequence(:name) { |n| "Garden#{n}"}
    zip_code { Faker::Address.zip_code }
    twitter_handle { Faker::Twitter.screen_name }
    tweet { true }
  end
  factory :plant do
    association :garden
     name { Faker::Name.first_name }
     species { Faker::Name.last_name }
     sequence(:frequency) { |n| 12 + n }
     last_watered { Faker::Time.day }
  end
end
