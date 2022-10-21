source 'http://rubygems.org'

gem 'rails', '~> 6.0.5.1'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'iconv'
gem 'tzinfo-data', '1.2020.3'
gem 'gravatar_image_tag', '1.2.0'
gem 'will_paginate', '3.3.0'

# Eventually want to migrate to ActiveStorage from deprecated Paperclip
#gem 'paperclip', '6.1.0'
# Temporary branch until paperclip 6.1.1 is released:
gem 'paperclip', git: 'https://github.com/sd/paperclip', branch: 'remove-mimemagic'
#gem 'aws-s3'
gem 'aws-sdk', '3.0.1'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  #gem 'sass-rails', "~> 3.1.0.rc"
  gem 'coffee-script-source', '1.8.0'
  gem 'coffee-rails', '5.0.0'
  #gem 'coffee-script'
  gem 'uglifier', '4.2.0'
end

gem 'jquery-rails', '4.4.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

# Bundle the extra gems:
gem 'nokogiri', '~> 1.13.9'

group :development do
  gem 'annotate', '2.4.0'
  gem 'faker', '0.3.1'
end

group :development, :test do
  gem 'sqlite3', '1.4.2'
  gem 'rspec-rails', '~> 4.0.1'
  gem 'capybara', '3.33.0'
  gem 'factory_bot_rails', '6.1.0'
  gem 'rails-controller-testing', '1.0.5'
end

group :test do
  gem 'webrat', '0.7.1'
  
  # Pretty printed test output
  gem 'turn', :require => false

  # gem 'autotest', '4.4.6'
  # gem 'autotest-rails-pure', '4.1.2'
  # gem 'autotest-standalone', '4.5.5'
  # gem 'autotest-growl', '0.2.9'
  # gem 'spork', '0.9.0.rc9'
end

group :production do
  # heroku cedar stack uses PostgreSQL database
  gem 'pg'
end
