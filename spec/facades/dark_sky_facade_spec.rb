require 'rails_helper'

describe 'Dark Sky Facade' do
  xit 'can find daily percipitation' do
    #this test depends on currently raining and so it is not a good test
    zip_code = "80026"
    forecast = DarkSkyFacade.raining?(zip_code)

    expect(forecast).to eq(true)
  end
end
