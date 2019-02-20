require 'rails_helper'

describe 'as a registered user' do
  describe 'when I visit the plant show page' do
    it 'and I click the water icon waterings should be created', :vcr do
      user = create(:user)
      garden = create(:garden, user: user)
      plant = create(:plant, garden: garden)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit plants_path

      expect(plant.waterings.count).to eq(0)

      click_button

      expect(plant.waterings.count).to eq(1)
    end
  end
  describe 'when I visit any page' do
    it 'and I click water all, waterings should be created for each plant', :vcr do
      user = create(:user)
      garden = create(:garden, user: user)
      plant_1 = create(:plant, garden: garden)
      plant_2 = create(:plant, garden: garden)
      plant_3 = create(:plant, garden: garden)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit plants_path

      expect(plant_1.waterings.count).to eq(0)
      expect(plant_2.waterings.count).to eq(0)
      expect(plant_3.waterings.count).to eq(0)

      click_on "Water All"

      expect(plant_1.waterings.count).to eq(1)
      expect(plant_2.waterings.count).to eq(1)
      expect(plant_3.waterings.count).to eq(1)
    end
  end
end
