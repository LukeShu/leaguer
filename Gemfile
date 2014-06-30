#!/usr/bin/ruby -h # not executable, but as a hint to text editors

source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

# bcrypt is used for password digesting
gem 'bcrypt-ruby', '3.1.2'

gem 'httparty'

gem 'simple_captcha2', require: 'simple_captcha'

group :development, :test do
	# Use sqlite3 as the database
	gem 'sqlite3'
end
group :production do
	# USe PostgresQL as the database
	gem 'pg'
end

# group :test do
# 	gem 'rspec-rails', '2.13.1'
# 	gem 'selenium-webdriver', '2.35.1'
# 	gem 'capybara', '2.1.0'
# end

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'
gem 'bootstrap-sass'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# Asynchronously handle longer or delayed tasks
gem 'daemons'
gem 'delayed_job_active_record'

# Mailboxer supports a messaging and alerting system.
gem 'mailboxer'

gem 'figaro'

group :doc do
	# bundle exec rake doc:rails generates the API under doc/api.
	gem 'sdoc', require: false
end


# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
# gem 'byebug', group: [:development, :test]
