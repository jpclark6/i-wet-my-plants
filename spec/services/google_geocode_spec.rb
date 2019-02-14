require 'rails_helper'

describe 'with a zip code' do
  it 'can send back lat long' do
    zip = 80204
    geo_service = GoogleGeocodeService.new(zip)
    expect(geo_service.lat).to eq(39.7380371)
    expect(geo_service.lng).to eq(-105.0265195)
  end

  it 'can send back a different lat long' do
    zip = 84103
    geo_service = GoogleGeocodeService.new(zip)
    expect(geo_service.lat).to eq(40.810506)
    expect(geo_service.lng).to eq(-111.8449346)
  end
end
