# frozen_string_literal: true

class Scenario < ApplicationRecord
  has_many :scenario_services, dependent: :destroy
  has_many :services, through: :scenario_services
  belongs_to :user
  accepts_nested_attributes_for :scenario_services

  validates :name, :user_id, presence: true
  validates_associated :scenario_services

  def services_name
    scenario_services.where.not(order: nil).sort_by { |sort| sort[:order] }.map { |ss| "#{ss.order}. #{ss.service.name} " }.join
  end
end
