require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'factory' do
    before do
      @profile = create(:profile)
    end

    it { expect(@profile).to be_valid }
  end
end
