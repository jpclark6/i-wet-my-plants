require 'rails_helper'

describe User do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:zip_code) }

  end
  describe 'relationships' do
    it { should have_many(:user_gardens) }
    it { should have_many(:gardens).through(:user_gardens) }
  end
end
