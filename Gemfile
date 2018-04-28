source 'https://rubygems.org'

gem 'active_model_serializers'
gem 'aws-sdk', '~> 2.3.0'
gem 'bcrypt', '~>3.1.7'
gem 'bundler', '>= 1.8.4'
gem 'dry-matcher'
gem 'iso_country_codes'
gem 'jwt'
gem 'multi_json'
gem 'paperclip', '~> 5.0.0'
gem 'pg', '< 1.0'
gem 'puma'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rack-cors', require: 'rack/cors'
gem 'rails', '~> 5.1'
gem 'rolify'
gem 'rubyXL'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'sidekiq'
gem 'simple_command'
gem 'trailblazer-rails', '~> 1.0'

# tags
gem 'acts-as-taggable-on', '~> 5.0'

# pubsub
gem 'redis'

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution
  # and get a debugger console
  gem 'byebug'
  gem 'factory_girl_rails'
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
  gem 'capistrano-rake', require: false
  gem 'capistrano-rvm', require: false
  gem 'capistrano-sidekiq', require: false
  gem 'capistrano3-puma', require: false
  gem 'capistrano-rails-console', require: false
  gem 'rubocop'
  gem 'sshkit-sudo', require: false
  gem 'story_branch'
  gem 'web-console', '~> 2.0'
end
