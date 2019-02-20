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
  describe 'when I visit a plant show page' do
    it 'should show watering schedule', :vcr do
      user = create(:user)
      garden = create(:garden, user: user)
      plant_1 = create(:plant, garden: garden)
      watering_1 = create(:watering, plant: plant_1, created_at: 2.days.ago )
      watering_2 = create(:watering, plant: plant_1, created_at: 1.day.ago)
      watering_3 = create(:watering, plant: plant_1, created_at: 7.days.ago)
      watering_4 = create(:watering, plant: plant_1, created_at: 6.days.ago)
      watering_5 = create(:watering, plant: plant_1, created_at: 8.days.ago)
      watering_6 = create(:watering, plant: plant_1, created_at: 5.days.ago)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit plant_path(plant_1)

      expect(page).to have_css('.waterings')
      within '.waterings' do
        expect(page).to have_content(watering_1.created_at)
        expect(page).to have_content(watering_2.created_at)
        expect(page).to have_content(watering_3.created_at)
        expect(page).to have_content(watering_4.created_at)
        expect(page).to have_content(watering_5.created_at)
        expect(page).to have_content(watering_6.created_at)
      end
    end
  end
end
