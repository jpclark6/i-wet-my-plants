require 'rails_helper'

describe 'with a zip code' do
  it 'can send back lat long' do
    zip = 80003
    geo_service = GoogleGeocodeService.new(zip)
    expect(geo_service.lat).to eq(39.8182494)
    expect(geo_service.lng).to eq(-105.0674317)
  end
end