require 'rails_helper'

describe Plant do
  describe 'relationships' do
    it { should belong_to :garden }
  end
  describe 'validations' do
    it { should validate_presence_of(:species) }
    it { should validate_presence_of(:frequency) }
  end
  describe 'instance methods' do
    it '.hours_since_watered' do
      garden = create(:garden)
      plant_1 = create(:plant, name: "Bob", species: "Rose", frequency: 12, last_watered: (Time.now - 60 * 60), garden: garden)
      expect(plant_1.hours_since_watered).to eq(1)

      plant_2 = create(:plant, name: "Bob", species: "Rose", frequency: 12, last_watered: (Time.now - 2 * 60 * 60), garden: garden)
      expect(plant_2.hours_since_watered).to eq(2)
    end
    it '.hours_until_watering' do
      garden = create(:garden)
      plant_1 = create(:plant, name: "Bob", species: "Rose", frequency: 12, last_watered: (Time.now - 60 * 60), garden: garden)
      expect(plant_1.hours_until_watering).to eq(11)

      plant_2 = create(:plant, name: "Bob", species: "Rose", frequency: 12, last_watered: (Time.now - 2 * 60 * 60), garden: garden)
      expect(plant_2.hours_until_watering).to eq(10)
    end
    it '.water_plant' do
      garden = create(:garden)
      plant_1 = create(:plant, name: "Bertha", species: "Rose", frequency: 24, last_watered: 2.days.ago, garden: garden)
      plant_1.water_plant
      expect(plant_1.hours_until_watering).to eq(plant_1.frequency)
    end
  end
  describe 'class methods' do
    it '#plants_that_need_watering' do
      user_1 = create(:user)
      garden = create(:garden)
      plant_1 = create(:plant, name: 'Alice', species: 'Rose', frequency: 12, garden: garden, last_watered: Time.now)
      plant_2 = create(:plant, name: 'Tom', species: 'Carrot', frequency: 5, garden: garden, last_watered: Time.now)
      plant_3 = create(:plant, name: 'Elbert', species: 'Beet', frequency: 4, garden: garden, last_watered: Time.now)
      expect(Plant.plants_that_need_watering).to eq([plant_3, plant_2])
    end
    it '#water_plant_from_key' do
      user_1 = create(:user)
      time = 5.hours.ago
      garden = create(:garden)
      plant_1 = create(:plant, name: 'Alice', species: 'Rose', frequency: 5, garden: garden, last_watered: time)
      api_key = Key.create_water_key(plant_1)
      key = Key.new(api_key)
      Plant.water_plant_from_key(key)
      expect(Plant.first.last_watered).to_not eq(time)
    end
  end
end
