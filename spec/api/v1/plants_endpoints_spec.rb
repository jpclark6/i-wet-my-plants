require 'rails_helper'

describe 'api for optional plant hardware' do
  it 'sends a secure list of plants that need to be watered to a select user' do
    user = create(:user)
    time = 5.hours.ago
    garden = Garden.create(name: 'Backyard', user: user, zip_code: 80026, twitter_handle: 'asdfasdf', tweet: false, secret_key: SecureRandom.hex(6))
    plant_1 = Plant.create(name: 'Alice', garden: garden, species: 'Rose', frequency: 24, last_watered: Time.now)
    plant_2 = Plant.create(name: 'Tom', garden: garden, species: 'Carrot', frequency: 12, last_watered: Time.now)
    plant_3 = Plant.create(name: 'Elbert', garden: garden, species: 'Beet', frequency: 3, last_watered: time)
    
    get "/api/v1/plants?key=#{garden.secret_key}"
    expect(response).to be_successful
    binding.pry
    data = JSON.parse(response.body, symbolize_names: true)
    expect(data[:data].length).to eq(1)
    expect(data[:data][0][:id]).to eq(plant_3.id.to_s)
    expect(data[:data][0][:type]).to eq('plant')
    expect(data[:data][0][:attributes][:name]).to eq(plant_3.name)
    expect(data[:data][0][:attributes][:species]).to eq(plant_3.species)

    expect(data[:data][0][:attributes][:secret]).to_not eq(nil)
  end
  it 'can accept a secure post request to water a plant' do
    user = create(:user)
    time = 5.hours.ago
    garden = Garden.create(name: 'Backyard', user: user, zip_code: 80026, twitter_handle: 'asdfasdf', tweet: false, secret_key: SecureRandom.hex(6))
    plant_1 = Plant.create(name: 'Alice', garden: garden, species: 'Rose', frequency: 24, last_watered: Time.now)
    plant_2 = Plant.create(name: 'Tom', garden: garden, species: 'Carrot', frequency: 5, last_watered: Time.now)
    plant_3 = Plant.create(name: 'Elbert', garden: garden, species: 'Beet', frequency: 3, last_watered: time)
    
    get "/api/v1/plants?key=#{garden.secret_key}"
    expect(response).to be_successful
    data_get = JSON.parse(response.body, symbolize_names: true)
    secret = data_get[:data][0][:attributes][:secret]

    post "/api/v1/plants?key=#{secret}"
    data_post = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(data_post[:status]).to eq("Plant #{plant_3.id} watered successfully")
    expect(Plant.find(plant_3.id).last_watered).to_not eq(time)

    post "/api/v1/plants?key=notthekey"
    data_post = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(data_post[:status]).to eq("Error. Something went wrong. Try again.")
  end
  it 'can return error response to bad request' do
    user = create(:user)
    time = 5.hours.ago
    garden = Garden.create(name: 'Backyard', user: user, zip_code: 80026, twitter_handle: 'asdfasdf', tweet: false, secret_key: SecureRandom.hex(6))
    plant_1 = Plant.create(name: 'Alice', garden: garden, species: 'Rose', frequency: 24, last_watered: Time.now)
    plant_2 = Plant.create(name: 'Tom', garden: garden, species: 'Carrot', frequency: 5, last_watered: Time.now)
    plant_3 = Plant.create(name: 'Elbert', garden: garden, species: 'Beet', frequency: 3, last_watered: time)
    
    get "/api/v1/plants?key=#{garden.secret_key}"
    expect(response).to be_successful
    data_get = JSON.parse(response.body, symbolize_names: true)
    secret = data_get[:data][0][:attributes][:secret]

    post "/api/v1/plants?key=notthekey"
    data_post = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(data_post[:status]).to eq("Error. Something went wrong. Try again.")
  end
  it 'can return response if all plants are watered' do
    user = create(:user)
    garden = Garden.create(name: 'Backyard', user: user, zip_code: 80026, twitter_handle: 'asdfasdf', tweet: false, secret_key: SecureRandom.hex(6))
    plant_1 = Plant.create(name: 'Alice', garden: garden, species: 'Rose', frequency: 24, last_watered: Time.now)
    plant_2 = Plant.create(name: 'Tom', garden: garden, species: 'Carrot', frequency: 5, last_watered: Time.now)
    plant_3 = Plant.create(name: 'Elbert', garden: garden, species: 'Beet', frequency: 3, last_watered: Time.now)
    
    get "/api/v1/plants?key=#{garden.secret_key}"
    expect(response).to be_successful
    data_get = JSON.parse(response.body, symbolize_names: true)
    expect(data_get[:status]).to eq("All plants currently watered")
  end
end