require 'rails_helper'

describe 'Dark Sky Api' do
  it 'can connect', :vcr do
    zip = 80204

    response = DarkSkyService.forecast(zip)
    keys = [:latitude, :longitude, :timezone, :currently, :minutely, :hourly, :daily, :flags, :offset]
    expect(response.keys).to eq(keys)
  end
end
