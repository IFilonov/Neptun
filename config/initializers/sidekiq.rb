require 'sidekiq'
require 'sidekiq-status'
require 'sidekiq-cron'

Sidekiq.logger = Rails.logger

Sidekiq.configure_server  do |config|
  config.redis =  { url: 'redis://localhost:6379/sidekiq_neptun'}
end

Sidekiq.configure_client  do |config|
  config.redis =  { url: 'redis://localhost:6379/sidekiq_neptun'}
end

Sidekiq::Queue.new("monitor").clear

if Rails.env.development? || Rails.env.test?
  require 'sidekiq/testing'
  Sidekiq::Testing.inline!
end

#StatesWorker.perform_async(5)
args = [ true ]
job = Sidekiq::Cron::Job.new(name: 'StatesWorker - every 5min', cron: '*/5 * * * *', class: 'StatesWorker', args: args)

if job.valid?
  job.save
  Rails.logger.info "Job saved succesfully #{job.name}: #{job.status}"
else
  Rails.logger.error job.errors
end