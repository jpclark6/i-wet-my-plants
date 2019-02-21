require 'rails_helper'

describe 'as a registered user' do
  describe 'when I visit my garden', :vcr do
    it 'shows current weather' do
      user_1 = create(:user)
      garden = create(:garden, user: user_1, zip_code: "80203")
      plant_1 = create(:plant, garden: garden, frequency: 24)
      plant_2 = create(:plant, garden: garden, frequency: 12)
      plant_3 = create(:plant, garden: garden, frequency: 18)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit plants_path

      expect(page).to have_content("Current Weather:")
      expect(page).to have_content("Denver")
      expect(page).to have_content("F")
    end
  end
end
