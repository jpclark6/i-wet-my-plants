require 'rails_helper'

describe 'Dark Sky Facade' do
  it 'can find current percipitation', :vcr do
    zip_code = "80026"
    allow(DarkSkyFacade).to receive(:current_precip_probability).with(zip_code).and_return(0.8)
    precipitation = DarkSkyFacade.current_precip_probability(zip_code)

    expect(precipitation).to eq(0.8)
  end

  it 'can tell you if its raining', :vcr do
    zip_code = "80026"
    allow(DarkSkyFacade).to receive(:raining?).with(zip_code).and_return(true)
    raining = DarkSkyFacade.raining?(zip_code)

    expect(raining).to eq(true)
  end
end
