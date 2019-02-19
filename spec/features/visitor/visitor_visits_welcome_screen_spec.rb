require 'rails_helper'

describe 'as a visitor on the welcome screen' do
  it 'shows link to login with facebook to signin or create an account', :vcr do
    visit '/'

    expect(page).to have_content("I Wet My Plants is an app that helps you remember to water the plants in your garden, and send you a friendly reminder if you forget.")

    expect(page).to have_link("Login with Facebook")
  end
  it 'shows link to login with a guest account', :vcr do
    user_2 = User.create(name: "Guest",  uid: '423145')
    garden = Garden.create(name: 'Backyard Garden', user: user_2, zip_code: 80401, twitter_handle: 'dsfiaon', tweet: false)
    Plant.create!(name: 'Alice', species: 'Rose', frequency: 12, garden: garden, last_watered: Time.new(2019,02,17,12,19,10))
    Plant.create!(name: 'Tom', species: 'Carrot', frequency: 5, garden: garden, last_watered: Time.new(2019,02,17,12,19,10))
    Plant.create!(name: 'Elbert', species: 'Beet', frequency: 4, garden: garden, last_watered: Time.new(2019,02,16,12,19,10))

    visit '/'

    expect(page).to have_link("Login as Guest")
    click_on 'Login as Guest'
    expect(current_path).to eq(plants_path)
  end
end
