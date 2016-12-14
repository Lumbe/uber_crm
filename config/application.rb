require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Workspace
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.i18n.default_locale = :ru
    config.autoload_paths += %W(#{config.root}/lib)
    config.time_zone = 'Kyiv'
    config.active_record.default_timezone = :local

    # default sass syntax fr rails generators
    if Rails.configuration.respond_to?(:sass)
      Rails.configuration.sass.tap do |config|
        config.preferred_syntax = :sass
      end
    end

    # load environment variables, defined in config/local_env.yml
    config.before_configuration do
      env_file = File.join(Rails.root, 'config', 'local_env.yml')
      YAML.load(File.open(env_file)).each do |key, value|
        ENV[key.to_s] = value
      end if File.exists?(env_file)
    end

    # Do not swallow errors in after_commit/after_rollback callbacks.
    # config.active_record.raise_in_transactional_callbacks = true
  end
end
