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
end
