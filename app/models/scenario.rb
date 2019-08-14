class Scenario < ApplicationRecord
  has_many :services, :through => :scenario_services

  validates :name, presence: true
end
