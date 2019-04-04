class Server < ApplicationRecord
  has_many :services

  validates :host_name, :ip, presence: true
  validates :host_name, uniqueness: true
end
