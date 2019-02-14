require 'rails_helper'

describe 'as a registered user' do
  it 'visits garden' do
    user_1 = User.create!(name: "Bobby", zip_code: 84928, uid: '49j8jesj')
    garden = Garden.create(name: 'Backyard', user: user_1)
    garden.plants << plant_1 = Plant.create(name: 'Alice', species: 'Rose', frequency: 24)
    gardens.first.plants << plant_2 = Plant.create(name: 'Tom', species: 'Carrot', frequency: 12)
    gardens.first.plants << plant_3 = Plant.create(name: 'Elbert', species: 'Beet', frequency: 18)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
    visit '/garden'
    within('.menu') do
      expect(page).to have_link('garden')
      expect(page).to have_link('Profile')
      expect(page).to have_link('Water All Plants')
      expect(page).to have_link('Logout')
    end

    within(all('.garden').first) do
      expect(page).to have_content(user_1.garden.name)
      expect(page).to have_link('Add Plant')
    end

    within(all('.plant').first) do
      expect(page).to have_content(plant_1.name)
      expect(page).to have_content(plant_1.species)
      expect(page).to have_content(plant_1.hours_until_watering)
      expect(page).to have_link("Edit")
      expect(page).to have_link("Water Plant")
    end
  end
end