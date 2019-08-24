class Scenario < ApplicationRecord
  has_many :scenario_services
  has_many :services, :through => :scenario_services
  accepts_nested_attributes_for :scenario_services

  validates :name, presence: true
  validates_associated :scenario_services

  MAX_COLUMNS = 4.freeze
  MAX_ROWS_IN_COLUMN = 20.freeze

  def clean_unselected_services
    scenario_services.delete(scenario_services.select { |item| item.order == nil })
  end

  def rows_and_columns(elements_count)
    columns_default = elements_count / MAX_ROWS_IN_COLUMN + 1
    columns = columns_default > MAX_COLUMNS ? MAX_COLUMNS : columns_default
    [elements_count / columns + 1, columns]
  end
end
