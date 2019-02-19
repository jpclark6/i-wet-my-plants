require "rails_helper"
describe 'as a registered user' do
  it 'creates a plant happy path', :vcr do
    user_1 = create(:user)
    garden = create(:garden, user: user_1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit '/plants'

    within('.menu') do
      expect(page).to have_link('Garden')
      expect(page).to have_button('Water All Plants')
      expect(page).to have_link('Logout')
    end

    expect(page).to have_link('Add Plant')

    click_on 'Add Plant'

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

    within('.menu') do
      expect(page).to have_link('Garden')
      expect(page).to have_button('Water All Plants')
      expect(page).to have_link('Logout')
    end

    expect(page).to have_link('Add Plant')

    click_on 'Add Plant'

    name = 'dave'
    frequency = '5'

   fill_in :plant_name, with: name
   fill_in :plant_frequency, with: frequency

   click_on 'Add Plant'

   expect(page).to have_content("species can't be blank")
 end
end
