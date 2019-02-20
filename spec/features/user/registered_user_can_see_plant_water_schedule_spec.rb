require 'rails_helper'

describe 'as a registered user' do
  describe 'when I visit the plant show page' do
    it 'should show the last 10 times I watered my plant', :vcr do
      user = create(:user)
      garden = create(:garden, user: user)
      plant = create(:plant, garden: garden)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit plants_path

      expect(plant.waterings.count).to eq(0)

      click_button

      expect(plant.waterings.count).to eq(1)
      expect(plant.hours_until_watering).to eq(plant.frequency)
    end
  end
end
