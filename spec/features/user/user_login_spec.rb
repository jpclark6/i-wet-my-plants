# require 'rails_helper'

# describe 'As a visitor to the site' do
#   describe 'when I visit the login path' do
#     it 'should let me log in' do
#       user = User.create(name: "dave", zip_code: "80203", uid: '428u988o4')
#       user.gardens << Garden.create(name: 'Backyard')
#       user.gardens.first.plants << plant_1 = Plant.new(name: 'Alice', species: 'Rose', frequency: 24)
#       user.gardens.first.plants << plant_2 = Plant.new(name: 'Tom', species: 'Carrot', frequency: 12)
#       user.gardens.first.plants << plant_3 = Plant.new(name: 'Elbert', species: 'Beet', frequency: 18)

#       visit login_path

#       fill_in :email, with: user.email
#       fill_in :password, with: user.password
#       click_button 'Log In'

#       expect(current_path).to eq(garden_path)
#       expect(page).to have_content("Logged In Successfully")
#     end

#     it 'cant log in with bad credentials' do
#       user = User.create(name: "dave", zip_code: "80203", email: 'email@aol.com', password: 'password')

#       visit login_path

#       fill_in :email, with: user.email
#       fill_in :password, with: "poop emoji"
#       click_button 'Log In'

#       expect(current_path).to eq(login_path)
#       expect(page).to have_content('Credentials Incorrect')

#     end

#     it 'should let me log out' do
#       user = User.create(name: "dave", zip_code: "80203", email: 'email@aol.com', password: 'password')
#       user.gardens << Garden.create(name: 'Backyard')
#       user.gardens.first.plants << plant_1 = Plant.new(name: 'Alice', species: 'Rose', frequency: 24)
#       user.gardens.first.plants << plant_2 = Plant.new(name: 'Tom', species: 'Carrot', frequency: 12)
#       user.gardens.first.plants << plant_3 = Plant.new(name: 'Elbert', species: 'Beet', frequency: 18)

#       visit login_path

#       fill_in :email, with: user.email
#       fill_in :password, with: user.password
#       click_button 'Log In'

#       expect(current_path).to eq(garden_path)
#       expect(page).to have_content("Logged In Successfully")

#       click_on "Logout"
#       expect(current_path).to eq(root_path)
#       expect(page).to have_content("You have logged out")
#     end
#   end
# end
