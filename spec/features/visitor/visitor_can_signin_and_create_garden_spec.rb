require 'rails_helper'

describe 'As a first time visitor to the site who signs in' do
  it 'I can create a garden', :vcr do
    visit '/'
    click_on "Login with Facebook"

    name = "Dave's Garden"
    twitter_handle = "iwetmyplants1"
    zip_code = 80203
    fill_in :garden_name, with: name
    fill_in :garden_twitter_handle, with: twitter_handle
    fill_in :garden_zip_code, with: zip_code
    click_on 'Create Garden'

    expect(current_path).to eq('/plants')
    expect(page).to have_content(name)
  end
end
