require "rails_helper"

describe 'as a registered user' do
  it 'can water a single plant' do
    yesterday = 1.day.ago
    two_days_ago = 2.days.ago
    user_1 = User.create(name: "Bobby", uid: '49j8jesj')
    garden = Garden.create(name: 'Backyard', user: user_1, zip_code: 84928, twitter_handle: 'asdfasdf')
    garden.plants << plant_1 = Plant.create(name: 'Alice', species: 'Rose', frequency: 24, last_watered: yesterday)
    garden.plants << plant_2 = Plant.create(name: 'Tom', species: 'Carrot', frequency: 12, last_watered: yesterday)
    garden.plants << plant_3 = Plant.create(name: 'Elbert', species: 'Beet', frequency: 18, last_watered: two_days_ago)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
    # As a registered user.

    visit '/plants'
    save_and_open_page
     # When I visit my user dashboard
    click_on "Water All Plants"
    # I see a button "Water All Plants" next to each plant.
    # When I click on "Water All Plants"
    expect(current_path).to eq(plants_path)
    # I will remain on the dashboard path
    within "#plant-#{plant_1.id}" do
      plant = Plant.find(plant_1.id)
      expect(plant.hours_until_watering).to eq(24)
      expect(plant.hours_since_watered).to eq(0)
      expect(page).to have_content(plant_1.hours_until_watering)
    end
    # The button will reset the clock timer for every plant in the garden.
    within "#plant-#{plant_2.id}" do
      plant = Plant.find(plant_1.id)
      expect(plant.hours_until_watering).to eq(12)
      expect(plant.hours_since_watered).to eq(0)
      expect(page).to have_content(plant_1.hours_until_watering)
    end
    # The button will reset the clock timer for every plant in the garden.
    within "#plant-#{plant_3.id}" do
      plant = Plant.find(plant_1.id)
      expect(plant.hours_until_watering).to eq(18)
      expect(plant.hours_since_watered).to eq(0)
      expect(page).to have_content(plant_1.hours_until_watering)
    end
    # The button will reset the clock timer for every plant in the garden.
  end
end
