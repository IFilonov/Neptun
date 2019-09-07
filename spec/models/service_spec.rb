require 'rails_helper'

describe Service, type: :model do
  it { should have_many(:scenario_services) }
  it { should belong_to(:server) }
  it { should belong_to(:group) }
  it { should belong_to(:user) }
  it { should have_many(:scenarios).through(:scenario_services) }

  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }

  describe 'get ordered' do
    let(:service1) { create(:service) }
    let(:service2) { create(:service) }

    it 'service can be ordered by group_id and id' do
#      user.award!(reward)

#      expect(reward).to eq user.rewards.last
    end
  end

end