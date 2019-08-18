class Scenario < ApplicationRecord
  has_many :services, :through => :scenario_services

  validates :name, presence: true

  MAX_COLUMNS = 4.freeze
  MAX_ROWS_IN_COLUMN = 20.freeze
end
