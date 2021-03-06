source 'https://rubygems.org'

gem 'rails', '>= 5.0.0.1', '< 5.1'

# fix version of sprockets to prevent deprecation warning.
# should be updated after less-rails fixed issue https://github.com/metaskills/less-rails/issues/122
gem "sprockets", '3.6.3'

# Use SCSS for stylesheets
gem 'sass-rails', '>= 5.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '>= 4.1.0'

# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

gem 'jquery-turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '>= 2.0'

# Send your data to js files
gem 'rabl-rails'

gem 'gon', '~> 6.1'

# excel spreadsheets generation
gem 'axlsx_rails', '~> 0.5.0'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'hamlit'

# fork from https://github.com/Lumbe/less-rails/tree/rails5 and merge pull request https://github.com/metaskills/less-rails/pull/123 to fix error
# should be updated after less-rails fixed issue https://github.com/metaskills/less-rails/issues/122
gem 'less-rails', :git => 'https://github.com/Lumbe/less-rails.git', :branch => 'rails5'

gem 'pg'

gem 'puma'

gem 'rails-i18n', '~> 5.0', '>= 5.0.1'

gem 'nokogiri'

gem 'kaminari'

gem 'ransack'

gem 'devise'

gem 'cancancan', '~> 1.15'

gem 'paperclip', '~> 5.1'

gem 'phony_rails'

gem 'public_activity'

gem 'premailer-rails'

# Action Mailer adapter for using Mailgun (https://mailgun.com)
gem 'mailgun_rails'

gem 'sidekiq'

gem 'ckeditor'

# ajax file uploads with remote forms
gem 'remotipart', '~> 1.2'
gem "sentry-raven"

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem "faker"
  gem 'rspec-rails', '~> 3.5'
  gem 'rails-controller-testing'
  gem 'factory_girl_rails', '~> 4.7'
  gem 'capybara', '~> 2.10'
  gem 'pry-rails'
end

group :test do
  gem 'shoulda-matchers', '~> 3.1'
  gem 'database_cleaner', '~> 1.5'
  gem 'simplecov', :require => false
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 3.3', '>= 3.3.1'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'capistrano',         require: false
  gem 'capistrano-rvm',     require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano3-puma',   require: false
  gem 'capistrano-sidekiq', require: false
end