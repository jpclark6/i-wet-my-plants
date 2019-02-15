require 'rails_helper'

describe 'As a first time visitor to the site who signs in' do
  it 'I can create a garden' do
    user_1 = User.create!(name: "Bobby", uid: '49j8jesj')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit '/gardens/new'

    name = "Dave's Garden"
    zip_code = 80203

    fill_in 'name', with: name
    fill_in 'twitter_handle', with: twitter_handle
    fill_in 'zip_code', with: zip_code
    click_on 'Create Garden'

    expect(current_path).to eq('/plants')
    expect(page).to have_content(name)
  end
end
