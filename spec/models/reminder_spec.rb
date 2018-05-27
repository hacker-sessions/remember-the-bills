require 'rails_helper'

RSpec.describe Reminder, type: :model do
  describe 'factory' do
    let(:reminder) { create(:reminder) }
    it { expect(reminder).to be_valid }
  end
end
