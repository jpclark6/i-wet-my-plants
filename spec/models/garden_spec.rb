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
      user_1 = create(:user)
      garden = create(:garden)
      plant_1 = create(:plant, name: 'Alice', species: 'Rose', frequency: 24, last_watered: Time.now, garden: garden)
      plant_2 = create(:plant, name: 'Tom', species: 'Carrot', frequency: 12, last_watered: Time.now, garden: garden)
      plant_3 = create(:plant, name: 'Elbert', species: 'Beet', frequency: 18, last_watered: Time.now, garden: garden)
      expect(garden.plants_by_water_need).to eq([plant_2, plant_3, plant_1])
    end
    it '.plants_that_need_water' do
      user_1 = create(:user)
      garden = create(:garden)
      plant_1 = create(:plant, name: 'Alice', species: 'Rose', frequency: 24, last_watered: 2.days.ago, garden: garden)
      plant_2 = create(:plant, name: 'Tom', species: 'Carrot', frequency: 5, last_watered: Time.now, garden: garden)
      plant_3 = create(:plant, name: 'Elbert', species: 'Beet', frequency: 7, last_watered: Time.now, garden: garden)
      expect(garden.plants_that_need_water).to eq([plant_1, plant_2])
    end
    it '.plants_that_need_water_api' do
      user_1 = create(:user)
      garden = create(:garden)
      plant_1 = create(:plant, name: 'Alice', species: 'Rose', frequency: 24, last_watered: 2.days.ago, garden: garden)
      plant_2 = create(:plant, name: 'Tom', species: 'Carrot', frequency: 5, last_watered: Time.now, garden: garden)
      plant_3 = create(:plant, name: 'Elbert', species: 'Beet', frequency: 7, last_watered: Time.now, garden: garden)
      expect(garden.plants_that_need_water_api).to eq([plant_1])
    end
  end
end
