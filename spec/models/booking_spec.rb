require 'rails_helper'

RSpec.describe Booking, type: :model do
  context 'Asociating' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:unit) }
  end
end
