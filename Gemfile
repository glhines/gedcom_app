source 'http://rubygems.org'

gem 'rails', '3.1.0.rc5'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'gravatar_image_tag', '1.0.0.pre2'
gem 'will_paginate', '3.0.pre4'
gem "paperclip", "~> 2.3"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "~> 3.1.0.rc"
  gem 'coffee-rails', "~> 3.1.0.rc"
  #gem 'coffee-script'
  gem 'uglifier'
end

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :development do
  gem 'sqlite3', '1.3.3'
  gem 'rspec-rails', '2.6.1'
  gem 'annotate', '2.4.0'
  gem 'faker', '0.3.1'
end

group :test do
  gem 'sqlite3', '1.3.3'
  gem 'rspec-rails', '2.6.1'
  gem 'webrat', '0.7.1'
  gem 'factory_girl_rails', '1.0'
  
  # Pretty printed test output
  gem 'turn', :require => false

  gem 'autotest', '4.4.6'
  gem 'autotest-rails-pure', '4.1.2'
  gem 'autotest-standalone', '4.5.5'
  gem 'autotest-growl', '0.2.9'
  gem 'spork', '0.9.0.rc9'
end

group :production do
  # heroku cedar stack uses PostgreSQL database
  gem 'pg'
end

