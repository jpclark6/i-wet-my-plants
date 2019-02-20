require 'rails_helper'

describe 'as a resgistered user on the garden' do
  it 'changes watering times if raining', :vcr do
    yesterday = 1.day.ago
    two_days_ago = 2.days.ago
    zip_code = 80203
    user_1 = create(:user)
    garden = create(:garden, name: "justin_test", zip_code: zip_code, user: user_1)
    plant_1 = create(:plant, garden: garden, frequency: 24, last_watered: two_days_ago)
    plant_2 = create(:plant, garden: garden, frequency: 12, last_watered: yesterday)
    plant_3 = create(:plant, garden: garden, frequency: 18, last_watered: yesterday)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit '/plants'

    within(all('.plant').first) do
      expect(Garden.find(garden[:id]).plants[0].hours_until_watering).to eq(-24)
      expect(Garden.find(garden[:id]).plants[0].hours_until_watering).to_not eq(24)
    end

    allow(DarkSkyFacade).to receive(:current_precip_probability).with(zip_code).and_return(0.9)
    CurrentPrecipitationService.new.get_precipitation

    visit '/plants'

    within(all('.plant').first) do
      expect(Garden.find(garden[:id]).plants[0].hours_until_watering).to eq(24)
      expect(Garden.find(garden[:id]).plants[0].hours_until_watering).to_not eq(-24)
    end
  end
end
