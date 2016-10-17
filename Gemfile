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
gem 'rails-i18n', '~> 5.0', '>= 5.0.1'

gem 'kaminari'
gem 'ransack'
gem 'devise'
gem 'cancancan', '~> 1.15'
gem 'paperclip', '~> 5.1'
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
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 3.3', '>= 3.3.1'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end
