# require 'rails_helper'
#
# describe 'when I visit the login path' do
#   it 'should let me log in' do
#     @uid = '12345'
#     OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
#       'credentials' => {'token' => ENV['GITHUB_API_KEY']},
#       'uid' => @uid
#     })
#     user_1 = User.create!(name: "Bobby", uid: '49j8jesj')
#     garden = Garden.create(name: 'Backyard', user: user_1, zip_code: 84928)
#     garden.plants << plant_1 = Plant.create(name: 'Alice', species: 'Rose', frequency: 24, last_watered: Time.now)
#     garden.plants << plant_2 = Plant.create(name: 'Tom', species: 'Carrot', frequency: 12, last_watered: Time.now)
#     garden.plants << plant_3 = Plant.create(name: 'Elbert', species: 'Beet', frequency: 18, last_watered: Time.now)
#
#     visit '/'
#
#     click_on 'Login with Facebook'
#
#     expect(current_path).to eq('/plants')
#     expect(page).to have_content("Logged In Successfully")
#   end
# end
