require 'rails_helper'

describe 'As a first time visitor to the site who signs in' do
  it 'I can create a garden' do
    user_1 = User.create!(name: "Bobby", uid: '49j8jesj')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit '/gardens/new'

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
