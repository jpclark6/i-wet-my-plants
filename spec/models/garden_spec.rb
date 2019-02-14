require 'rails_helper'

describe Garden do
  describe 'validations' do
    it { should validate_presence_of(:name) }

  end
  describe 'relationships' do
    it { should belong_to(:user) }
  end
end
