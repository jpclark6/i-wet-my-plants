require "rails_helper"
describe 'as a registered user' do
  it 'sees a plant happy path' do
    user_1 = User.create!(name: "Bobby", uid: '49j8jesj')
    garden = Garden.create(name: 'Backyard', user: user_1, zip_code: 84928, twitter_handle: 'asdfasdf')
    plant_1 = garden.plants.create(name: 'Alice', species: 'Rose', frequency: 24, last_watered: Time.now)
    plant_2 = garden.plants.create(name: 'Tom', species: 'Carrot', frequency: 12, last_watered: "2019-02-09")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    # As registered user.
    visit plant_path(plant_1.id)
    # When I visit 'pants/:id'
    # I see the plant name, watering history, a place to leave notes.
    expect(page).to have_content("Name: #{plant_1.name}")
    expect(page).to have_content("Last Watered: #{plant_1.last_watered.to_date}")
    expect(page).to_not have_content("Name: #{plant_2.name}")
    expect(page).to_not have_content("Last Watered: #{plant_2.last_watered.to_date}")

    expect(page).to have_button("Edit Plant")
    # I see "Edit Plant"
    expect(page).to have_button("Kill Me")
    # and "Kill Me" buttons
  end
  it 'create a plant happy path' do
    user_1 = User.create!(name: "Bobby", uid: '49j8jesj')
    garden = Garden.create(name: 'Backyard', user: user_1, zip_code: 84928, twitter_handle: 'asdfasdf')
    plant_1 = garden.plants.create(name: 'Alice', species: 'Rose', frequency: 24, last_watered: Time.now)
    plant_2 = garden.plants.create(name: 'Tom', species: 'Carrot', frequency: 12, last_watered: "2019-02-09")
    # As a registered user.
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
    visit '/plants'
    # When I visit my garden,
    within('.menu') do
      expect(page).to have_link('Garden')
      expect(page).to have_button('Water All Plants')
      expect(page).to have_link('Logout')
    end
    within('.garden') do
      expect(page).to have_link('Add Plant')
      click_on 'Add Plant'
    end
    # I should see a "Add plant" link,

    name = 'dave'
    species = 'species 1'
    frequency = '5'

    fill_in 'name', with: name
    fill_in 'species', with: species
    fill_in 'frequency', with: frequency
    # When I fill those fields with valid input
    click_on 'Create Plant'
    #I should click "Create plant"
    plant_id = Plant.all.last.id
    expect(current_path).to eq(plants_path(plant_id))
    #I should be in the plant's show page
    expect(page).to have_content("Your plant was added")
    #and see a message "Your plant was added".
  end

  it 'it cannot create a plant with bad info' do
    user_1 = User.create(name: "Bobby", uid: '49j8jesj')
    garden = Garden.create(name: 'Backyard', user: user_1, zip_code: 84928, twitter_handle: "Maddie")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
    # As a registered user.
    visit '/plants'

    within('.garden') do
      expect(page).to have_link('Add Plant')
      click_on 'Add Plant'
    end

    name = 'dave'
    frequency = '5'

    fill_in 'name', with: name
    fill_in 'frequency', with: frequency
    # When I fill those fields with invalid input
    click_on 'Create Plant'
    #I should click "Create plant"
    expect(page).to have_content("species can't be blank")
  # I see a message "Incorrect Info"
 end
 it 'can edit plant' do
   user_1 = User.create!(name: "Bobby", uid: '49j8jesj')
   garden = Garden.create!(name: 'Backyard', user: user_1, zip_code: 84928, twitter_handle: 'Maddie')
   plant_1 = Plant.create!(name: 'Alice', species: 'Rose', frequency: 24, last_watered: Time.now, garden: garden)
   allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

   visit '/plants'

   expect(page).to have_link('Edit')

   click_on 'Edit'

   expect(current_path).to eq(edit_plant_path(plant_1))

   name = 'maddie'
   species = 'species 3'
   frequency = '18'

   fill_in 'plant[name]', with: name
   fill_in 'plant[species]', with: species
   fill_in 'plant[frequency]', with: frequency

   click_on 'Update Plant'

   plant_1.update(name: name, species: species, frequency: frequency)

   expect(current_path).to eq(plants_path)
   expect(plant_1.name).to eq('maddie')
   expect(plant_1.species).to eq('species 3')
   expect(plant_1.frequency).to eq(18)
 end
end
