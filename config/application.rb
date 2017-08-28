require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MXEDU
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.cache_store = :dalli_store

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.active_record.default_timezone = :local
    config.time_zone = 'Beijing'

    # 配置跨域
    # Avoid CORS issues when API is called from the frontend app.
    # Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.
    # Read more: https://github.com/cyu/rack-cors
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :put, :patch, :delete, :options]
      end
    end

    ENV["DB_USER"] = 'mida'
    ENV["DB_PASSWORD"] = '112420'
    ENV["SECRET_KEY_BASE"] = 'f13760bb00730dca6334207b7339526310205d1891f3007c9c81052e67c241c87e249874f136c3522a8ab8b30398e8ea18ef78ef7c88541a3f44e3da6966bf69'
  end
end
