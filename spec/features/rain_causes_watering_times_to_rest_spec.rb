require 'rails_helper'

describe 'as a resgistered user on the garden' do
  xit 'changes watering times if raining', :vcr do
    user_1 = create(:user)
    garden = create(:garden, user: user_1)
    plant_1 = create(:plant, name: 'Alice', species: 'Rose', frequency: 24, garden: garden)
    plant_2 = create(:plant, name: 'Tom', species: 'Carrot', frequency: 12, garden: garden)
    plant_3 = create(:plant, name: 'Elbert', species: 'Beet', frequency: 18, garden: garden)
    lat_lon = "37.8267,-122.4233"
    DarkSkyService.forecast(lat_lon)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit '/garden'

    within(all('.plant').first) do
      expect(plant_1.hours_until_watering).to eq(1)
      expect(plant_1.hours_until_watering).to_not eq(1)
    end
  end
end
