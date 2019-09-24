require 'sidekiq'
require 'sidekiq-status'

if Rails.env.development? || Rails.env.test?
  require 'sidekiq/testing'
  Sidekiq::Testing.inline!
end

Sidekiq.logger = Rails.logger

Sidekiq.configure_server  do |config|
  config.redis =  { url: 'redis://localhost:6379/sidekiq_neptun'}
end

Sidekiq.configure_client  do |config|
  config.redis =  { url: 'redis://localhost:6379/sidekiq_neptun'}
end

Sidekiq::Queue.new("monitor").clear
