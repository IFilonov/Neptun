class Service < ApplicationRecord
  belongs_to :server
  belongs_to :group
  belongs_to :user
  has_many :scenario_services
  has_many :scenarios, through: :scenario_services

  validates :name, presence: true
  validates :name, uniqueness: true

  MAX_COLUMNS = 4.freeze
  MAX_ROWS_IN_COLUMN = 20.freeze

  scope :odd_groups, -> { Service.distinct.pluck(:group_id) }

  def self.ordered
    Service.order(:group_id, :id)
  end

  def self.positions
    Service.joins(:group).distinct.pluck(:position).sort;
  end

  def self.service_columns
    size = Service.all.size
    columns_default = size / MAX_ROWS_IN_COLUMN + 1
    columns_default > MAX_COLUMNS ? MAX_COLUMNS : columns_default
  end

  def do_state(ssh)
    send_command(:state.to_s, nil, nil, ssh)
  end

  def send_command(service_attribute_name, login, password, ssh = nil)
    ssh = ssh ? ssh : SshService.new(server.host_name, login, password)
    ssh.send_command_sudo(sudo_name)
    ssh.send_command(path)
    answer = ssh.send_command(read_attribute(service_attribute_name))
    ssh.close
    answer.byteslice(0, 2000).split(/\n/).join('\n')
  end
end
