require 'rails_helper'

RSpec.describe UserGarden, type: :model do
  describe 'relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:garden) }
  end
end
