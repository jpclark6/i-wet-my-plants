require 'rails_helper'

describe 'as a visitor on the welcome screen' do
  it 'shows link to sign up or register an account' do
    visit '/'

    expect(page).to have_content("I Wet My Plants is an app that helps you
                                  remember to water the plants in your garden,
                                  and send you a friendly reminder if you forget.
                                  ")

    expect(page).to have_button("Register")
    expect(page).to have_button("Sign-In")
  end
end
