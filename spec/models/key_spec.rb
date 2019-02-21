require 'rails_helper'

describe Key do
  describe 'instance methods' do
    it 'exists' do
      user = create(:user)
      time = 5.hours.ago
      garden = Garden.create(name: 'Backyard', user: user, zip_code: 80026, twitter_handle: 'asdfasdf', tweet: false, secret_key: SecureRandom.hex)
      plant = Plant.create(name: 'Elbert', garden: garden, species: 'Beet', frequency: 3, last_watered: time)
      key = Key.new(plant)
      expect(key.class).to eq(Key)
    end
    it 'valid?' do
      user = create(:user)
      time = 5.hours.ago
      garden = Garden.create(name: 'Backyard', user: user, zip_code: 80026, twitter_handle: 'asdfasdf', tweet: false, secret_key: SecureRandom.hex)
      plant = Plant.create(name: 'Elbert', garden: garden, species: 'Beet', frequency: 3, last_watered: time)
      
      valid_api_key = Key.create_water_key(plant)
      invalid_api_key = Key.create_water_key(plant) + "x"

      valid_key = Key.new(valid_api_key)
      invalid_key = Key.new(invalid_api_key)

      expect(valid_key.valid?).to eq(true)
      expect(invalid_key.valid?).to eq(false)
    end
    it 'plant_id' do
      user = create(:user)
      time = 5.hours.ago
      garden = Garden.create(name: 'Backyard', user: user, zip_code: 80026, twitter_handle: 'asdfasdf', tweet: false, secret_key: SecureRandom.hex)
      plant = Plant.create(name: 'Elbert', garden: garden, species: 'Beet', frequency: 3, last_watered: time)
      key = Key.new(Key.create_water_key(plant))
      expect(key.plant_id).to eq(plant.id)
    end
  end
  describe 'class methods' do
    it '.create_water_key' do
      user = create(:user)
      time = 5.hours.ago
      garden = Garden.create(name: 'Backyard', user: user, zip_code: 80026, twitter_handle: 'asdfasdf', tweet: false, secret_key: SecureRandom.hex)
      plant = Plant.create(name: 'Elbert', garden: garden, species: 'Beet', frequency: 3, last_watered: time)
      message = "#{plant.id}.#{1.hour.from_now}"
      key = Digest::SHA256.hexdigest "#{message}#{ENV['HARDWARE_SECRET_API']}"
      expect(Key.create_water_key(plant)).to eq("#{message}.#{key}")
    end
  end
end