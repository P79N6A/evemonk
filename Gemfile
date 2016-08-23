source 'https://rubygems.org'

gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'

gem 'jquery-rails'
gem 'turbolinks', '~> 5'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'

gem 'bcrypt'
gem 'swagger-blocks'
gem 'eve_online'
gem 'bullet'
gem 'has_secure_token'
gem 'good_migrations'
gem 'rack-cors', require: 'rack/cors'
gem 'kaminari'
gem 'rectify'
gem 'draper'
gem 'dotenv'
gem 'pundit'

# for testing ony
gem 'sqlite3'

group :production do
  gem 'pg'
  gem 'lograge'
end

group :development, :test do
  # gem 'sqlite3'
  gem 'rspec-rails'
  gem 'awesome_print', require: 'ap'
  gem 'pry-rails'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'brakeman', require: false
  gem 'rubocop', require: false
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-faster-assets'
  gem 'capistrano-rbenv'
  gem 'capistrano-rbenv-install'
end

group :test do
  gem 'shoulda-matchers'
  gem 'rspec-its'
  gem 'rspec-activemodel-mocks'
  gem 'simplecov', require: false
  gem 'codeclimate-test-reporter', require: false
end
