require 'rails_helper'

describe 'as a registered user' do
  it 'visits dashboard' do
    user_1 = User.create(name: "Bobby", zip_code: 84928)
    user_1.gardens << Garden.create(name: 'Backyard')
    user_1.gardens.first.plants << plant_1 = Plant.new(name: 'Alice', species: 'Rose', frequency: 24)
    user_1.gardens.first.plants << plant_2 = Plant.new(name: 'Tom', species: 'Carrot', frequency: 12)
    user_1.gardens.first.plants << plant_3 = Plant.new(name: 'Elbert', species: 'Beet', frequency: 18)


    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
    visit '/dashboard'
    within('.menu') do
      expect(page).to have_link('Dashboard')
      expect(page).to have_link('Profile')
      expect(page).to have_link('Water All Plants')
      expect(page).to have_link('Logout')
    end

    within(all('.plant').first) do
      expect(page).to have_content(plant_1.name)
      expect(page).to have_content(plant_1.species)
      expect(page).to have_content(plant_1.hours_since_watered)
      expect(page).to have_content(plant_1.hours_until_watering)
      expect(page).to have_link("Edit")
      expect(page).to have_link("Water Plant")
    end
  end
end