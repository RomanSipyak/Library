require 'rails_helper'

RSpec.describe Estimate, type: :model do
  context 'Asociating' do
    it { is_expected.to belong_to(:for_user) }
    it { is_expected.to belong_to(:book) }

  end
end
