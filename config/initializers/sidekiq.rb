require 'sidekiq/api'

Sidekiq.configure_server  do |config|
  config.redis =  { url: 'redis://localhost:6379/sidekiq_neptun'}
end

Sidekiq.configure_client  do |config|
  config.redis =  { url: 'redis://localhost:6379/sidekiq_neptun'}
end

Sidekiq::Queue.new("monitor").clear
