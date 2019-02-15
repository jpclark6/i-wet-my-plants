describe 'as a registered user' do
  it 'visits garden' do
    user_1 = User.create!(name: "Bobby", uid: '49j8jesj')
    garden = Garden.create(name: 'Backyard', user: user_1, zip_code: 84928)
    garden.plants << plant_1 = Plant.create(name: 'Alice', species: 'Rose', frequency: 24, last_watered: Time.now)
    garden.plants << plant_2 = Plant.create(name: 'Tom', species: 'Carrot', frequency: 12, last_watered: Time.now)
    garden.plants << plant_3 = Plant.create(name: 'Elbert', species: 'Beet', frequency: 18, last_watered: Time.now)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
    # As a registered user.
    visit '/plants'
    # When I visit my garden,
    within('.menu') do
      expect(page).to have_link('Garden')
      expect(page).to have_link('Water All Plants')
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
   plant_id = Plants.all.last.id
   expect_current(path).to eg(plants_path(plant_id))
   #I should be in the plant's show page
   expect(page).to have_content("Your plant was added")
   #and see a message "Your plant was added".
  end
end
