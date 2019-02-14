require 'rails_helper'

describe 'Dark Sky Api' do
  it 'can connect' do
    lat_lon = "37.8267,-122.4233"
    response = DarkSkyService.forecast(lat_lon)

    expect(response[:latitude]).to eq(37.8267)
    expect(response[:longitude]).to eq(-122.4233)
  end
end
