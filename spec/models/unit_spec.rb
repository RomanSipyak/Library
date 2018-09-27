require 'rails_helper'

RSpec.describe Unit, type: :model do
  context 'Asociating' do
    it { is_expected.to belong_to(:book) }
    it { is_expected.to have_many(:bookings) }
  end
end
