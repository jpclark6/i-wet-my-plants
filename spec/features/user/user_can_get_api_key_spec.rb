require 'rails_helper'

describe 'as a user' do
  it 'has a key for hardware', :vcr do
    user_1 = create(:user)
    garden = Garden.create(name: 'Backyard', user: user_1, zip_code: 80026, twitter_handle: 'asdfasdf', secret_key: 'sdafion42')
    plant_1 = Plant.create(name: 'Alice', garden: garden, species: 'Rose', frequency: 24, last_watered: Time.now)
    plant_2 = Plant.create(name: 'Tom', garden: garden, species: 'Carrot', frequency: 12, last_watered: Time.now)
    plant_3 = Plant.create(name: 'Elbert', garden: garden, species: 'Beet', frequency: 18, last_watered: Time.now)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit '/plants'
    expect(page).to have_content("Hardware Key: #{garden.secret_key}")
  end
end