require 'rails_helper'

describe 'as a registered user' do
  it 'can log me out', :vcr do
    user_1 = create(:user)
    garden = create(:garden, user: user_1)
    plant_1 = create(:plant, garden: garden)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit '/plants'

    within('.menu') do
      click_on('Logout')
    end
    expect(current_path).to eq('/')
    expect(current_path).to_not eq('/plants')
  end
end
