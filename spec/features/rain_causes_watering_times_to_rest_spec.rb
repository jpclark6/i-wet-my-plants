require 'rails_helper'

describe 'as a resgistered user on the dashboard' do
  xit 'changes watering times if raining' do
    user_1 = User.create(name: "Bobby", zip_code: 84928)
    user_1.gardens << Garden.create(name: 'Backyard')
    user_1.gardens.first.plants << plant_1 = Plant.new(name: 'Alice',
                                                        species: 'Rose',
                                                        frequency: 24)
    user_1.gardens.first.plants << plant_2 = Plant.new(name: 'Tom',
                                                        species: 'Carrot',
                                                        frequency: 12)
    user_1.gardens.first.plants << plant_3 = Plant.new(name: 'Elbert',
                                                        species: 'Beet',
                                                        frequency: 18)
    lat_lon = "37.8267,-122.4233"
    DarkSkyService.forecast(lat_lon)



    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit '/dashboard'

    within(all('.plant').first) do
      binding.pry
      expect(plant_1.hours_until_watering).to eq(1)
      expect(plant_1.hours_until_watering).to_not eq(1)
    end
  end
end
