require 'rails_helper'

describe 'As a visitor to the site' do
  describe 'when I visit the login path' do
    it 'should let me log in' do
      user = create(:user, email: 'email1@aol.com', password: 'password1')

      visit login_path

      fill_in :email, with: user.email
      fill_in :password, with: user.password
      click_button 'Log In'

      expect(current_path).to eq(profile_path)
      expect(page).to have_content("Logged In Successfully")
    end
  end
end
