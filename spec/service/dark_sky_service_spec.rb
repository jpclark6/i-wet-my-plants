require 'rails_helper'

describe 'Dark Sky Api' do
  it 'can connect' do
    lat_lon = "37.8267,-122.4233"
    response = DarkSkyService.conn(lat_lon)

    expect(response.status).to eq(200)
  end
end
