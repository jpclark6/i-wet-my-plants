require 'rails_helper'

describe 'As a visitor to the site' do
  describe 'when I visit the login path' do
    it 'should let me log in' do
      user = User.create(name: "dave", zip_code: "80203", email: 'email@aol.com', password: 'password')
      user.gardens << Garden.create(name: 'Backyard')
      user.gardens.first.plants << plant_1 = Plant.new(name: 'Alice', species: 'Rose', frequency: 24)
      user.gardens.first.plants << plant_2 = Plant.new(name: 'Tom', species: 'Carrot', frequency: 12)
      user.gardens.first.plants << plant_3 = Plant.new(name: 'Elbert', species: 'Beet', frequency: 18)

      visit login_path

      fill_in :email, with: user.email
      fill_in :password, with: user.password
      click_button 'Log In'

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Logged In Successfully")
    end
  end
end
