# frozen_string_literal: true

class StatesWorker
  include Sidekiq::Worker
  sidekiq_options queue: :monitor

  def perform(duration)
    ssh_connection_pool = []
    services = Service.all.order(:id)

    loop do
      puts "StatesWorker #{duration} sec processed!"
      services.reload
      services.each do |s|
        status = s.status || 0
        next unless s&.user&.ldap_login && s&.user&.password && s&.state

        puts "Service #{s.name} processed!"
        puts s.state
        begin
          ssh_connection_pool[s.id] ||= SshService.new(s.server.host_name,
                                                       s.user.ldap_login,
                                                       s.user.ldap_password)
          status = s.do_state(ssh_services[s.id]).to_i
          puts "State #{s.name} processed!"
        rescue SocketError
          status -= 1
        end
        s.save! if status != s.status
      end

      sleep duration
    end
    puts 'Exit!'
  end
end
