require 'rails_helper'

describe Garden do
  describe 'validations' do
    it { should validate_presence_of(:name) }

  end
  describe 'relationships' do
    it { should have_one(:user) }
  end
end
