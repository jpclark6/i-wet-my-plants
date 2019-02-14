require 'rails_helper'

describe 'Dark Sky Facade' do
  it 'can find daily percipitation' do
    lat_lon = "37.8267,-122.4233"
    forecast = DarkSkyFacade.raining?(lat_lon)

    expect(forecast).to eq(true)
  end
end
