class Service < ApplicationRecord
  belongs_to :server
  belongs_to :group
  has_many :scenario_services
  has_many :scenarios, through: :scenario_services


  validates :name, presence: true
  validates :name, uniqueness: true

  scope :odd_groups, -> { Service.distinct.pluck(:group_id) }

  def self.positions
    Service.joins(:group).distinct.pluck(:position).sort;
  end
end
