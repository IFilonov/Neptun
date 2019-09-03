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

  def self.ordered(ldap_login, ldap_password)
    @@ldap_login = ldap_login
    @@ldap_password = ldap_password
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

  def run_start
    send_command(start)
  end

  def run_stop
    send_command(stop)
  end

  def run_restart
    send_command(restart)
  end

  def run_state
    send_command(state)
  end

  private

  def send_command(cmd)
    ssh = SshService.new(server.host_name, @@ldap_login, @@ldap_password)
    ssh.send_command("sudo -u #{sudo_name} -i") if sudo_name&.length > 0
    ssh.send_command(path) if path&.length > 0
    answer = ssh.send_command(cmd)
    ssh.close
    answer.byteslice(0, 2000).split(/\n/).join('\n')
  end
end
