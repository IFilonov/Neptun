# frozen_string_literal: true

class StatesWorker
  include Sidekiq::Worker
  sidekiq_options queue: :monitor

  def perform(*args)
    exit = args[0]
    ssh_connection_pool = []

    Rails.logger.info "------ StatesWorker started"

    services = Service.includes(:user).order(:id)

    loop do
      services.reload
      services.each do |s|
        status = s.status || 0
        next unless s&.user&.ldap_login && s&.user&.ldap_password && s&.state

        Rails.logger.info "--- StatesWorker service #{s.name} processed! state = #{s.state}"
        begin
          ssh_connection_pool[s.id] ||= SshService.new(s.server.host_name,
                                                       s.user.ldap_login,
                                                       s.user.ldap_password)
          status = s.do_state(ssh_services[s.id]).to_i
        rescue SocketError
          status = -1
          Rails.logger.info "--- StatesWorker error, status #{s.status} !"
        end
        save_status(s, status)
      end
      break if exit
      sleep 5
    end
    Rails.logger.info '------ StatesWorker exit!'
  end

  def save_status(service, status)
    if status != service.status
      service.status = status
      service.save!
      Rails.logger.info "--- StatesWorker saved, status #{service.status} !"
    end
  end
end
