require 'rails_helper'

describe 'api for optional plant hardware' do
  it 'sends a secure list of plants that need to be watered to a select user' do
    user = create(:user)
    time = 5.hours.ago
    garden = Garden.create(name: 'Backyard', user: user, zip_code: 80026, twitter_handle: 'asdfasdf', tweet: false, secret_key: SecureRandom.hex)
    plant_1 = Plant.create(name: 'Alice', garden: garden, species: 'Rose', frequency: 24, last_watered: Time.now)
    plant_2 = Plant.create(name: 'Tom', garden: garden, species: 'Carrot', frequency: 12, last_watered: Time.now)
    plant_3 = Plant.create(name: 'Elbert', garden: garden, species: 'Beet', frequency: 3, last_watered: time)
    
    get "/api/v1/plants?key=#{garden.secret_key}"
    expect(response).to be_successful
    data = JSON.parse(response.body, symbolize_names: true)
    expect(data[:data].length).to eq(1)
    expect(data[:data][0][:id]).to eq(plant_3.id.to_s)
    expect(data[:data][0][:type]).to eq('plants')

    expect(data[:data][0][:attributes][:secret]).to_not eq(nil)
  end
  it 'can accept a secure post request to water a plant' do
    user = create(:user)
    time = 5.hours.ago
    garden = Garden.create(name: 'Backyard', user: user, zip_code: 80026, twitter_handle: 'asdfasdf', tweet: false, secret_key: SecureRandom.hex)
    plant_1 = Plant.create(name: 'Alice', garden: garden, species: 'Rose', frequency: 24, last_watered: Time.now)
    plant_2 = Plant.create(name: 'Tom', garden: garden, species: 'Carrot', frequency: 12, last_watered: Time.now)
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
  end
end

# require 'digest'

# # Compute a complete digest
# Digest::SHA256.digest 'message'


# describe "Invoice API" do
#   it "sends a list of invoices" do
#     create_list(:invoice, 3)

#     get '/api/v1/invoices.json'

#     expect(response).to be_successful

#     invoice_data = JSON.parse(response.body)

#     expect(invoice_data["data"].length).to eq(3)

#     expect(invoice_data["data"][0]["attributes"]["customer_id"]).to eq(Invoice.first.customer_id)
#     expect(invoice_data["data"][1]["attributes"]["customer_id"]).to eq(Invoice.second.customer_id)
#     expect(invoice_data["data"][2]["attributes"]["customer_id"]).to eq(Invoice.third.customer_id)
#     expect(invoice_data["data"][2]["type"]).to eq("invoice")