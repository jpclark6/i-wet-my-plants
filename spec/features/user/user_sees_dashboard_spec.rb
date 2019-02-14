# require 'rails_helper'

# describe 'as a registered user' do
#   it 'visits dashboard' do
#     user = User.create(name: "Bob Dallas", zip_code: "84238")

#     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
#     visit '/dashboard'
#     within('.menu') do
#       expect(page).to have_link('Dashboard')
#       expect(page).to have_link('Profile')
#       expect(page).to have_link('Water All Plants')
#       expect(page).to have_link('Logout')
#     end
#   end
# end



# As a registered user
# When I visit '/dashboard'
# I see a heading 'My Garden".
# I see a drop down menu with options to go home, profile, logout, water all plants.
# I see all plants with their name, hours since it was watered, hours until it needs water, edit, a water plant button.
# The plants will be organized by highest need of water.