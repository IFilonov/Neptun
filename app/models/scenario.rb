class Scenario < ApplicationRecord
  has_many :services, :through => :scenario_services
end
