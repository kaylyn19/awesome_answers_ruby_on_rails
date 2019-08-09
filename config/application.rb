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
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AwesomeAnswersMay
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # This tells Rails' ActiveJob to use the gem "delayed_job" to manage our job queue which will use a table in our database
    config.active_job.queue_adapter = :delayed_job
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Don't generate system test files.
    config.generators.system_tests = nil
    config.generators do |g|
      g.helper = false
      g.assets = false
    end

    # configure CORS
    config.middleware.insert_before 0, Rack::Cors do # Rails config, we want to add sth in middleware at the very front and pass a lambda (Rack::Cors)
      allow do
        origins('127.0.0.1:5500', 'localhost:8080', 'localhost:3001') # which domains are allowed to make a request to the domain
        resource '/api/*', headers: :any, credentials: true, methods: [:get, :post, :delete, :patch, :put, :options] # limit what resources those domains can access
        # headers: :any this allows ll HTTP headers to be sent
        # credentials: true allows sharing of cookies for CORS requests made to this resource; if there's cookie stored in the browser we can send a requeset to this endpoint
        # methods: [:get, :post, :delete, :patch, :put, :options] defines the HTTP verbs which are allowed in a request
      end
    end

  end
end
