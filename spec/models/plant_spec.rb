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
      garden = Garden.create(name: 'Sally')
      plant_1 = Plant.create(name: "Bob", species: "Rose", frequency: 12, last_watered: (Time.now - 60 * 60), garden: garden)
      expect(plant_1.hours_since_watered).to eq(1)
      
      plant_2 = Plant.create(name: "Bob", species: "Rose", frequency: 12, last_watered: (Time.now - 2 * 60 * 60), garden: garden)
      expect(plant_2.hours_since_watered).to eq(2)
    end
    it '.hours_until_watering' do
      garden = Garden.create(name: 'Sally')
      plant_1 = Plant.create(name: "Bob", species: "Rose", frequency: 12, last_watered: (Time.now - 60 * 60), garden: garden)
      expect(plant_1.hours_until_watering).to eq(11)
      
      plant_2 = Plant.create(name: "Bob", species: "Rose", frequency: 12, last_watered: (Time.now - 2 * 60 * 60), garden: garden)
      expect(plant_2.hours_until_watering).to eq(10)
    end
  end
end