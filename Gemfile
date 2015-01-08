source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
# gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
# gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

gem "activeadmin", github: "gregbell/active_admin" # Until it's 1.0.0
gem "devise"

group :development do
  gem "better_errors"
  gem "meta_request"
  gem "quiet_assets"
end

group :development, :test do
  gem "capybara"
  gem "capybara-screenshot"
  gem "database_cleaner"
  gem "factory_girl_rails"
  gem "faker"
  gem "poltergeist"
  gem "pry-nav"
  gem "pry-rails"
  gem "pry-stack_explorer"
  gem "pry-theme"
  gem "rspec-rails"
  gem "rubocop"
  gem "shoulda-matchers"
  gem "spring-commands-rspec"
  gem 'web-console', '~> 2.0'
end

gem "active_model_serializers"
gem "grape"
gem "grape-active_model_serializers"
gem "grape-swagger-rails"
gem "rack-cors", require: "rack/cors"
gem "hashie_rails"

# Model history
gem 'paper_trail', '~> 3.0.3'

#Heroku integration has previously relied on using the Rails plugin system, which has been removed from Rails 4. To enable features such as static asset serving and logging on Heroku please add
gem 'rails_12factor', group: :production

#i18n
gem 'globalize', '~> 4.0.2'
gem 'globalize-versioning'
gem 'batch_translations'
gem 'route_translator'
gem 'activeadmin-translate', github: 'rbatllet/activeadmin-translate'
#gem 'activeadmin-translate'

#Image upload
gem "mini_magick"
gem 'carrierwave'

#Geocoding
gem "geocoder"

#Config files
gem "rails_config"

#Support of respond_to and respond_with for Rails 4.2
#gem 'responders', '~> 2.0'