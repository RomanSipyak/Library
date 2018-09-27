require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Asociating' do
    it { is_expected.to have_many(:estimates) }
  end
end
