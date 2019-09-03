class StatesWorker
  include Sidekiq::Worker

  def perform(duration)

    ssh_services = []
    loop do

      sleep duration

      Service.all.each do |s|
        if s.user && s.state && s.user.ldap_login && s.user.ldap_password
          begin
          ssh_services[s.id] ||= SshService.new(s.server.host_name, s.user.ldap_login, s.user.ldap_password)
          s.status = ssh_services[s.id].run_state
          s.save!
          rescue SocketError => error
            s.status = ssh_services[s.id].run_state
            end
          end
        end
      end

    end
  end
end
