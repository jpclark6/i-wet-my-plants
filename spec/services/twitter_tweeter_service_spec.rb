require 'rails_helper'

describe 'as our app' do
  it 'can tweet as itself' do
    user_1 = User.create!(name: "Bobby",  uid: '3297328fha')
    garden = Garden.create!(name: 'Backyard', user: user_1, zip_code: 84928, twitter_handle: 'tomm3923')
    Plant.create!(name: 'Alice', species: 'Rose', frequency: 24, garden: garden, last_watered: Time.now)
    Plant.create!(name: 'Tom', species: 'Carrot', frequency: 25, garden: garden, last_watered: Time.now)
    Plant.create!(name: 'Elbert', species: 'Beet', frequency: 24, garden: garden, last_watered: Time.now)

    twitter = TwitterTweeterService.new
    message =  twitter.send_tweets

    expect(message).to eq("Success")
  end
end