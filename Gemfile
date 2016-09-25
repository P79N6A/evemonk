source 'https://rubygems.org'

gem 'rails', '~> 5.0.0'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'

gem 'bcrypt'
gem 'eve_online'
gem 'good_migrations'
gem 'rack-cors', require: 'rack/cors'
gem 'kaminari'
gem 'rectify'
gem 'draper', '3.0.0.pre1'
gem 'dotenv'
gem 'pundit'
gem 'sidekiq'

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
  gem 'bullet'
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
  gem 'rails-controller-testing'
  gem 'shoulda-matchers'
  gem 'rspec-its'
  gem 'rspec-activemodel-mocks'
  gem 'simplecov', require: false
  gem 'codeclimate-test-reporter', require: false
end
