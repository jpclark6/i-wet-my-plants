require 'rails_helper'

describe 'As a registered user' do
  it 'you cannot create a garden or visit garden create form' do
    yesterday = 1.day.ago
    two_days_ago = 2.days.ago
    zip_code = 80203
    user_1 = create(:user)
    garden = create(:garden, name: "justin_test", zip_code: zip_code, user: user_1)
    plant_1 = create(:plant, garden: garden, frequency: 24, last_watered: two_days_ago)
    plant_2 = create(:plant, garden: garden, frequency: 12, last_watered: yesterday)
    plant_3 = create(:plant, garden: garden, frequency: 18, last_watered: yesterday)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit '/gardens/new'

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end
end
