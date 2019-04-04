class Service < ApplicationRecord
  belongs_to :server
  belongs_to :group

  validates :name, presence: true
  validates :name, uniqueness: true

  scope :odd_groups, -> { Service.distinct.pluck(:group_id) }

  def self.positions
    Service.joins(:group).distinct.pluck(:position).sort;
  end
end
