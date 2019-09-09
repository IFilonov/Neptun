# frozen_string_literal: true

class ScenarioService < ApplicationRecord
  belongs_to :scenario
  belongs_to :service

  validates :scenario_id, uniqueness: { scope: :service_id }
end
