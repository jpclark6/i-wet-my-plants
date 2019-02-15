require 'rails_helper'

describe 'as a registered user' do
  it 'can log me out' do
    user_1 = User.create!(name: "Bobby", uid: '49j8jesj')
    garden = Garden.create(name: 'Backyard', user: user_1, zip_code: 84928)
    garden.plants << plant_1 = Plant.create(name: 'Alice', species: 'Rose', frequency: 24, last_watered: Time.now)
    garden.plants << plant_2 = Plant.create(name: 'Tom', species: 'Carrot', frequency: 12, last_watered: Time.now)
    garden.plants << plant_3 = Plant.create(name: 'Elbert', species: 'Beet', frequency: 18, last_watered: Time.now)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit '/plants'

    within('.menu') do
      click_on('Logout')
    end
    expect(current_path).to eq('/')
    expect(current_path).to_not eq('/plants')
  end
end
