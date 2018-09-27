require 'rails_helper'

RSpec.describe Book, type: :model do
  context 'Asociating' do
    it { is_expected.to belong_to(:author) }
    it { is_expected.to belong_to(:category) }
    it { is_expected.to belong_to(:language) }
    it { is_expected.to have_many(:units) }
    it { is_expected.to have_many(:estimates) }
   it { is_expected.to have_many(:users) }
  end
end
