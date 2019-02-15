require 'rails_helper'

describe 'as a visitor on the welcome screen' do
  it 'shows link to login with facebook to signin or create an account' do
    visit '/'

    expect(page).to have_content("I Wet My Plants is an app that helps you remember to water the plants in your garden, and send you a friendly reminder if you forget.")

    expect(page).to have_link("Login with Facebook")
  end
end
