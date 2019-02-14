require 'rails_helper'

describe 'Dark Sky Api' do
  it 'can connect' do
    zip = 80204

    response = DarkSkyService.forecast(zip)

    expect(response.status).to eq(200)
  end
end
