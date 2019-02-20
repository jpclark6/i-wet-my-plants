require 'rails_helper'

describe 'as a registered user' do
  describe 'when I visit the index page' do
    it 'should show hours until watering in red if the value is less than 0', :vcr do
      yesterday = 1.day.ago
      two_days_ago = 2.days.ago
      user_1 = create(:user)
      garden = create(:garden, user: user_1)
      plant = create(:plant, garden: garden, frequency: 18, last_watered: two_days_ago)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit plants_path

      within '.plant' do
        expect(page).to have_css('.red')
      end
    end
    it 'should show hours until watering in green if the value is more than 24', :vcr do
      yesterday = 1.day.ago
      two_days_ago = 2.days.ago
      user_1 = create(:user)
      garden = create(:garden, user: user_1)
      plant = create(:plant, garden: garden, frequency: 72, last_watered: yesterday)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit plants_path

      within '.plant' do
        expect(page).to have_css('.green')
      end
    end
    it 'should show hours until watering in yellow if the value is between 0 and 24', :vcr do
      yesterday = 1.day.ago
      two_days_ago = 2.days.ago
      user_1 = create(:user)
      garden = create(:garden, user: user_1)
      plant = create(:plant, garden: garden, frequency: 26, last_watered: yesterday)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit plants_path

      within '.plant' do
        expect(page).to have_css('.yellow')
      end
    end
  end
end
