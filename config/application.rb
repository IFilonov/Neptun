require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
 require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Neptun
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.

    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.i18n.default_locale = :ru
    config.active_job.queue_adapter = :sidekiq

    logger = ActiveSupport::Logger.new(ENV['LOG_FILE'] || STDOUT)
    logger.formatter = ::Logger::Formatter.new
    logger.level = ENV['LOG_LEVEL'] || 'INFO'
    config.logger = ActiveSupport::TaggedLogging.new(logger)
    ActiveAdmin.setup do |config|
      config.use_webpacker = true
    end
  end
end
