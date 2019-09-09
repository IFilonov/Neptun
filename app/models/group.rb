# frozen_string_literal: true

class Group < ApplicationRecord
  has_many :services

  validates :name, presence: true
  validates :name, uniqueness: true
end
