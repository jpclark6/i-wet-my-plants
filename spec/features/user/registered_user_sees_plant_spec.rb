require "rails_helper"

describe 'as a registered user' do
  it 'sees a plant happy path', :vcr do
    yesterday = 1.day.ago
    user_1 = create(:user)
    garden = create(:garden, user: user_1)
    plant_1 = create(:plant, garden: garden, last_watered: yesterday)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit plant_path(plant_1.id)

    expect(page).to have_content("Name: #{plant_1.name}")
    expect(page).to have_content("Last Watered: #{plant_1.last_watered.to_date}")

    expect(page).to have_link("Edit Plant")
    expect(page).to have_link("Kill Me")
  end
  it 'create a plant happy path', :vcr do
    user_1 = create(:user)
    garden = create(:garden, user: user_1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit '/plants'

    within('.menu') do
      expect(page).to have_link('Garden')
      expect(page).to have_button('Water All Plants')
      expect(page).to have_link('Logout')
    end
    within('.add_plant') do
      expect(page).to have_link('Add Plant')
      click_on 'Add Plant'
    end

    name = 'dave'
    species = 'species 1'
    frequency = '5'

    fill_in :plant_name, with: name
    fill_in :plant_species, with: species
    fill_in :plant_frequency, with: frequency
    click_on 'Add Plant'

    plant_id = Plant.all.last.id
    expect(current_path).to eq(plants_path(plant_id))
    expect(page).to have_content("Your plant was added")
  end
  it 'it cannot create a plant with bad info', :vcr do
    user_1 = create(:user)
    garden = create(:garden, user: user_1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit '/plants'

    within('.add_plant') do
      expect(page).to have_link('Add Plant')
      click_on 'Add Plant'
    end

    name = 'dave'
    frequency = '5'

    fill_in :plant_name, with: name
    fill_in :plant_frequency, with: frequency

    click_on 'Add Plant'

    expect(page).to have_content("species can't be blank")
 end
 it 'can edit plant', :vcr do
   user_1 = create(:user)
   garden = create(:garden, user: user_1)
   plant_1 = Plant.create!(name: 'Alice', species: 'Rose', frequency: 24, garden: garden)
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
 it 'cannot edit plant with missing species plant', :vcr do
   user_1 = create(:user)
   garden = create(:garden, user: user_1)
   plant_1 = Plant.create!(name: 'Alice', species: 'Rose', frequency: 24, garden: garden)
   allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

   visit edit_plant_path(plant_1)

   name = 'maddie'
   frequency = '18'

   fill_in 'plant[name]', with: name
   fill_in 'plant[species]', with: ""
   fill_in 'plant[frequency]', with: frequency

   click_on 'Update Plant'

   expect(page).to have_content("species can't be blank")
 end

 it 'cannot edit plant with missing frequency plant', :vcr do
   user_1 = create(:user)
   garden = create(:garden, user: user_1)
   plant_1 = create(:plant, name: 'Alice', species: 'Rose', frequency: 24, garden: garden)
   allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

   visit edit_plant_path(plant_1)

   name = 'maddie'
   species = 'plant_1'

   fill_in 'plant[name]', with: name
   fill_in 'plant[species]', with: species
   fill_in 'plant[frequency]', with: ""

   click_on 'Update Plant'

   expect(page).to have_content("frequency can't be blank")
 end
 it 'can edit plant from plant show page', :vcr do
   user_1 = create(:user)
   garden = create(:garden, user: user_1)
   plant_1 = create(:plant, name: 'Alice', species: 'Rose', frequency: 24, garden: garden)
   allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

   visit plant_path(plant_1)

   expect(page).to have_link('Edit Plant')

   click_on 'Edit Plant'

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
 it 'can delete plant', :vcr do
   user_1 = create(:user)
   garden = create(:garden, user: user_1)
   plant_1 = create(:plant, name: 'Alice', species: 'Rose', frequency: 24, garden: garden)
   plant_2 = create(:plant, garden: garden)

   allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

   visit plant_path(plant_1)

   click_on "Kill Me"

   expect(current_path).to eq(plants_path)
   expect(page).to have_content("Your plant has been murdered")
   expect(page).to_not have_content(plant_1.name)
   expect(page).to_not have_content(plant_1.species)
   expect(page).to have_content(plant_2.name)
 end
end
