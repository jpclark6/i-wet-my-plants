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

  it 'can create messages' do
    user_1 = User.create!(name: "Bobby",  uid: '3297328fha')
    garden = Garden.create!(name: 'Backyard', user: user_1, zip_code: 84928, twitter_handle: 'tomm3923')
    plant_1 = Plant.create!(name: 'Alice', species: 'Rose', frequency: 24, garden: garden, last_watered: Time.now)
    plant_2 = Plant.create!(name: 'Tom', species: 'Carrot', frequency: 4, garden: garden, last_watered: Time.now)
    plant_3 = Plant.create!(name: 'Elbert', species: 'Beet', frequency: 4, garden: garden, last_watered: Time.now)

    twitter = TwitterTweeterService.new
    message = twitter.create_message(plant_2)
    expect(message).to include(garden.twitter_handle)
    expect(message).to include(plant_2.name)
    expect(message).to include(plant_2.species)
  end
end