require 'rails_helper'

describe Garden do
  describe 'validations' do
    it { should validate_presence_of(:name) }

  end
  describe 'relationships' do
    it { should have_many(:user_gardens) }
    it { should have_many(:users).through(:user_gardens) }
  end
end
