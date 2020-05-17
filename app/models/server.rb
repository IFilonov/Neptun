# frozen_string_literal: true

class Server < ApplicationRecord
  has_many :services

  validates :name, :ip, presence: true
  validates :name, uniqueness: true
end
