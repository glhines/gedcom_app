source "http://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.8", ">= 7.0.8.4"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use sqlite3 as the database for Active Record
gem "sqlite3", "~> 1.7", ">= 1.7.2"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0", ">= 5.6.8"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use for getting gravatar image of a user
# gem "gravatar_image_tag", "1.2.0" #currently still uses deprecated URI#escape
# Currently bypassing this gem in users_helper.rb with direct call to gravatar.com

# Use for views needing pagination
gem "will_paginate", "3.3.0"

# Is iconv still needed in Ruby 3.2.2?
gem 'iconv'

# Eventually want to migrate to ActiveStorage from deprecated Paperclip
#gem 'paperclip', '6.1.0'
# Temporary branch until paperclip 6.1.1 is released:
gem "paperclip", git: 'https://github.com/sd/paperclip', branch: 'remove-mimemagic'

#gem 'aws-s3'
gem "aws-sdk", "3.0.1"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  #gem 'sass-rails', "~> 3.1.0.rc"
  gem "coffee-script-source", "1.8.0"
  gem "coffee-rails", "5.0.0"
  #gem 'coffee-script'
  gem "uglifier", "4.2.0"
end

gem "jquery-rails", "4.4.0"

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  gem "annotate", "2.4.0"
  gem "faker", "0.3.1"
end

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]

  gem "rspec-rails", "~> 4.0.1"
  gem "capybara"
  gem "factory_bot_rails", "6.1.0"
  gem "rails-controller-testing", "1.0.5"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "selenium-webdriver", "~> 4.11"
  
  gem "webrat", "0.7.1"
  gem "turn", :require => false
end

group :production do
  # heroku cedar stack uses PostgreSQL database
  gem "pg"
end

# Bundle the extra gems:
# gem 'bj'
gem "nokogiri", "~> 1.16", ">= 1.16.5"
gem "net-http"
