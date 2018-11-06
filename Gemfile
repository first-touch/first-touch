source 'https://rubygems.org'

gem 'active_model_serializers'
# tags
gem 'acts-as-taggable-on', '~> 5.0'
gem 'aws-sdk-s3', '~> 1'
gem 'bcrypt', '~>3.1.7'
gem 'bundler', '>= 1.8.4'
gem 'devise'
gem 'dry-matcher'
gem 'iso_country_codes'
gem 'jwt'
gem 'multi_json'
gem 'pg', '< 1.0'
gem 'puma'
gem 'stripe'
gem 'paper_trail'
gem 'rack-cors', require: 'rack/cors'
gem 'rails'
# pubsub
gem 'redis'
gem 'rolify'
gem 'rubyXL'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'sidekiq'
gem 'simple_command'
gem 'simple_token_authentication'
gem 'trailblazer-rails', '~> 2.1'
gem "reform-rails"
gem 'activerecord_json_validator'

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution
  # and get a debugger console
  gem 'byebug'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-json_expectations'
  gem 'rspec-rails', '~> 3.0'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'timecop'
end

group :test do
  gem 'json-schema'
end

# Use Capistrano for deployment
group :development do
  gem 'capistrano', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-rails-console', require: false
  gem 'capistrano-rake', require: false
  gem 'capistrano-rvm', require: false
  gem 'capistrano-sidekiq', require: false
  gem 'capistrano3-puma', require: false
  gem 'rubocop'
  gem 'sshkit-sudo', require: false
  gem 'story_branch'
  gem 'web-console', '~> 2.0'
end
