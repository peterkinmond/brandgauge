source 'https://rubygems.org'

#core stuff
gem 'rails', '3.2.2'
gem 'mysql2'
gem 'haml'
gem 'thin'

# rails helper things
gem 'devise'
gem 'simple_form'

#twitter streaming stuff
gem 'tweetstream'
gem 'klout'
gem 'yajl-ruby'
gem 'redis'
gem 'resque', :require => "resque/server"

#Make redis available as Rails.cache
gem 'redis-rails'

#monitoring
gem 'rpm_contrib'
gem 'newrelic_rpm'

# admin gem
gem "meta_search",    '>= 1.1.0.pre'
gem 'activeadmin', :git => "https://github.com/gregbell/active_admin.git"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer'

  gem 'uglifier', '>= 1.0.3'
end

group :test, :development do
  gem 'heroku'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'sqlite3'
  gem 'awesome_print'
  gem 'foreman'
  gem 'guard-rspec'
end

gem 'jquery-rails'
