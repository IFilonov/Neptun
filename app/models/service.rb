class Service < ApplicationRecord
  belongs_to :server
  belongs_to :group
  has_many :scenario_services
  has_many :scenarios, through: :scenario_services

  validates :name, presence: true
  validates :name, uniqueness: true

  MAX_COLUMNS = 4.freeze
  MAX_ROWS_IN_COLUMN = 20.freeze

  scope :odd_groups, -> { Service.distinct.pluck(:group_id) }

  def self.positions
    Service.joins(:group).distinct.pluck(:position).sort;
  end

  def self.service_columns
    size = Service.all.size
    columns_default = size / MAX_ROWS_IN_COLUMN + 1
    columns_default > MAX_COLUMNS ? MAX_COLUMNS : columns_default
  end
end
