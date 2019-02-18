require 'rails_helper'

describe Garden do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:twitter_handle) }
    it { should validate_presence_of(:zip_code) }

  end
  describe 'relationships' do
    it { should belong_to(:user) }
    it { should have_many(:plants) }
  end
  describe 'instance methods' do
    it '.plants_by_water_need' do
          user_1 = User.create!(name: "Bobby", uid: '49j8jesj')
          garden = Garden.create(name: 'Backyard', user: user_1, zip_code: 80026, twitter_handle: 'asdfasdf')
          garden.plants << plant_1 = Plant.create(name: 'Alice', species: 'Rose', frequency: 24, last_watered: Time.now)
          garden.plants << plant_2 = Plant.create(name: 'Tom', species: 'Carrot', frequency: 12, last_watered: Time.now)
          garden.plants << plant_3 = Plant.create(name: 'Elbert', species: 'Beet', frequency: 18, last_watered: Time.now)
          expect(garden.plants_by_water_need).to eq([plant_2, plant_3, plant_1])
    end
  end
end
