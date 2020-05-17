# frozen_string_literal: true

class ScenarioWorker
  include Sidekiq::Worker
  sidekiq_options queue: :monitor

  def perform(scenario_id)
    ssh_connection_pool = []
    Rails.logger.info "------ StatesWorker started"
    scenario = Scenario.includes(:services).find(scenario_id)

    Rails.logger.info "--- Scenario.services.count #{scenario.services.count}!"

#    loop do
#      Rails.logger.info "------ StatesWorker processed"
#      services.reload
#      services.each do |s|
#        status = s.status || 0
#        next unless s&.user&.ldap_login && s&.user&.ldap_password && s&.state

#        Rails.logger.info "--- Service #{s.name} processed! state = #{s.state}"
#        begin
#          ssh_connection_pool[s.id] ||= SshService.new(s.server.name,
#                                                       s.user.ldap_login,
#                                                       s.user.ldap_password)
#          status = s.do_state(ssh_services[s.id]).to_i
#          status = 500
#          Rails.logger.info "--- State #{s.name} done!"
#        rescue SocketError
#          status = -1
#          Rails.logger.info "--- Error, status #{s.status} !"
#        end
#        if status != s.status
#          s.status = status
#          s.save!
#          Rails.logger.info "--- Saved, status #{s.status} !"
#        end
#      end
#      break if exit
#      sleep 5
#    end
   Rails.logger.info '------ ScenarioWorker exit!'
  end
end
