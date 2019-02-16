require 'rails_helper'

describe 'as our app' do
  it 'can tweet as itself' do
    twitter = TwitterTweeterService.new
    binding.pry

    expect(true).to eq(true)
  end
end