FactoryBot.define do
  factory :watering do
    
  end

  factory :user do
    sequence(:name) { |n| "Lisa#{n}"}
    sequence(:uid) { |n| "#{n}9j8jesj" }
  end
  factory :garden do
    association :user
    sequence(:name) { |n| "Garden#{n}"}
    zip_code { '80026' }
    twitter_handle { Faker::Twitter.screen_name }
    tweet { true }
  end
  factory :plant do
    association :garden
     name { Faker::Name.first_name }
     species { Faker::Name.last_name }
     sequence(:frequency) { |n| 12 + n }
     last_watered { Faker::Time.between(DateTime.now - 1, DateTime.now) }
  end
end
