require 'rails_helper'

describe Service, type: :model do
  it { should have_many(:scenario_services) }
  it { should belong_to(:server) }
  it { should belong_to(:group) }
  it { should belong_to(:user) }
  it { should have_many(:scenarios).through(:scenario_services) }

  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }

  describe 'ordered services' do
    let!(:group1) { create(:group_with_services) }
    let!(:group2) { create(:group_with_services) }

    it 'service can be ordered by group_id' do
      expect(Service.ordered.first.group_id).to eq group1.id
      expect(Service.ordered.last.group_id).to eq group2.id
    end

    it 'and else service can be ordered by id' do
      expect(Service.ordered.first.id).to eq group1.services.first.id
      expect(Service.ordered.last.id).to eq group2.services.last.id
    end

  end

  describe 'get ordered' do
    let!(:group1) { create(:group_with_services) }
    let!(:group2) { create(:group_with_services) }

    it 'service can be ordered by group_id and id' do
      expect(Service.ordered.first).to eq group1.services.first
      expect(Service.ordered.last).to eq group2.services.last
    end
  end

end