# frozen_string_literal: true

class Service < ApplicationRecord
  belongs_to :server
  belongs_to :group
  belongs_to :user
  has_many :scenario_services
  has_many :scenarios, through: :scenario_services

  validates :name, presence: true
  validates :name, uniqueness: true

  MAX_COLUMNS = 4
  MAX_ROWS_IN_COLUMN = 20

  def self.ordered
    Service.order(:group_id, :id)
  end

  def self.service_columns(size = nil)
    size ||= Service.all.size
    columns_default = size / MAX_ROWS_IN_COLUMN + 1
    columns_default > MAX_COLUMNS ? MAX_COLUMNS : columns_default
  end

  def do_state(ssh)
    send_command(:state.to_s, nil, nil, ssh)
  end

  def send_command(service_attr_name, login, password, ssh = nil)
    begin
      ssh ||= SshService.new(server.host_name, login, password)
      ssh.send_command_sudo(sudo_name)
      ssh.send_command(path)
      answer = ssh.send_command(read_attribute(service_attr_name)).byteslice(0, 2000).split(/\n/).join('\n')
      ssh.close
      answer
    rescue SocketError => e
      "Error: #{e.message}"
    end
  end
end
