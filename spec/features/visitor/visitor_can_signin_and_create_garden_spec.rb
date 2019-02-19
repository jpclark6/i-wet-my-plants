require 'rails_helper'

describe 'As a first time visitor to the site who signs in', :vcr do
  it 'I can create a garden' do
    name = "Dave's Garden"
    twitter_handle = "iwetmyplants1"
    zip_code = 80203
    
    user_1 = create(:user)
    Garden.create(name: name, twitter_handle: twitter_handle, zip_code: zip_code, user: user_1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit '/gardens/new'


    fill_in :garden_name, with: name
    fill_in :garden_twitter_handle, with: twitter_handle

    fill_in :garden_zip_code, with: zip_code
    click_on 'Create Garden'

    expect(current_path).to eq('/plants')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
    expect(page).to have_content(name)
  end
end
