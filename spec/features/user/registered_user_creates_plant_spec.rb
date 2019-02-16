describe 'as a registered user' do
  it 'creates a plant happy path' do
    user_1 = User.create!(name: "Bobby", uid: '49j8jesj')
    garden = Garden.create(name: 'Backyard', user: user_1, zip_code: 84928, twitter_handle: 'asdfasdf')
    garden.plants << plant_1 = Plant.create(name: 'Alice', species: 'Rose', frequency: 24, last_watered: Time.now)
    garden.plants << plant_2 = Plant.create(name: 'Tom', species: 'Carrot', frequency: 12, last_watered: Time.now)
    garden.plants << plant_3 = Plant.create(name: 'Elbert', species: 'Beet', frequency: 18, last_watered: Time.now)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit '/plants'

    within('.menu') do
      expect(page).to have_link('Garden')
      expect(page).to have_link('Water All Plants')
      expect(page).to have_link('Logout')
    end
    within('.garden') do
    expect(page).to have_link('Add Plant')
    click_on 'Add Plant'
    end

    name = 'dave'
    species = 'species 1'
    frequency = '5'

    fill_in 'name', with: name
    fill_in 'species', with: species
    fill_in 'frequency', with: frequency

    click_on 'Create Plant'

    plant_id = Plant.all.last.id
    expect(current_path).to eq(plants_path(plant_id))

    expect(page).to have_content("Your plant was added")
  end

  it 'it cannot create a plant with bad info' do
    user_1 = User.create!(name: "Bobby", uid: '49j8jesj')
    garden = Garden.create(name: 'Backyard', user: user_1, zip_code: 84928, twitter_handle: 'asdfasdf')
    garden.plants << plant_1 = Plant.create(name: 'Alice', species: 'Rose', frequency: 24, last_watered: Time.now)
    garden.plants << plant_2 = Plant.create(name: 'Tom', species: 'Carrot', frequency: 12, last_watered: Time.now)
    garden.plants << plant_3 = Plant.create(name: 'Elbert', species: 'Beet', frequency: 18, last_watered: Time.now)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit '/plants'

    within('.menu') do
      expect(page).to have_link('Garden')
      expect(page).to have_link('Water All Plants')
      expect(page).to have_link('Logout')
    end
    within('.garden') do
    expect(page).to have_link('Add Plant')
    click_on 'Add Plant'
    end

    name = 'dave'
    frequency = '5'

   fill_in 'name', with: name
   fill_in 'frequency', with: frequency

   click_on 'Create Plant'

   expect(page).to have_content("species can't be blank")
 end
end
