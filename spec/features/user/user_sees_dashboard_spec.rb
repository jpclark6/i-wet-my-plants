require 'rails_helper'

describe 'as a registered user' do
  it 'visits garden and sees plants in correct order' do
    user_1 = User.create!(name: "Bobby", uid: '49j8jesj')
    garden = Garden.create(name: 'Backyard', user: user_1, zip_code: 80026, twitter_handle: 'asdfasdf')
    garden.plants << plant_1 = Plant.create(name: 'Alice', species: 'Rose', frequency: 24, last_watered: Time.now)
    garden.plants << plant_2 = Plant.create(name: 'Tom', species: 'Carrot', frequency: 12, last_watered: Time.now)
    garden.plants << plant_3 = Plant.create(name: 'Elbert', species: 'Beet', frequency: 18, last_watered: Time.now)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
    visit '/plants'
    within('.menu') do
      expect(page).to have_link('Home')
      expect(page).to have_button('Water All Plants')
      expect(page).to have_link('Logout')
    end

    expect(page).to have_content(user_1.garden.name)
    expect(page).to have_link('Add Plant')

    within(all('.plant').first) do
      expect(page).to have_content(plant_2.name)
      expect(page).to have_content(plant_2.species)
      expect(page).to have_content(plant_2.hours_until_watering)
      expect(page).to have_link("Edit")
      expect(page).to have_button()
    end
  end

  it 'can turn twitter on and off if it wants to' do
    user_1 = User.create!(name: "Bobby", uid: '49j8jesj')
    garden = Garden.create(name: 'Backyard', user: user_1, zip_code: 80026, twitter_handle: 'asdfasdf')
    garden.plants << plant_1 = Plant.create(name: 'Alice', species: 'Rose', frequency: 24, last_watered: Time.now)
    garden.plants << plant_2 = Plant.create(name: 'Tom', species: 'Carrot', frequency: 12, last_watered: Time.now)
    garden.plants << plant_3 = Plant.create(name: 'Elbert', species: 'Beet', frequency: 18, last_watered: Time.now)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
    visit '/plants'

    click_on 'Turn Tweets Off'
    expect(current_path).to eq(plants_path)
    expect(page).to have_content('Tweets have been turned off')

    click_on 'Turn Tweets On'
    expect(current_path).to eq(plants_path)
    expect(page).to have_content('Tweets have been turned on')
  end
end
