source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'rails', '~> 5.2.3'
gem 'puma', '~> 3.11'
gem 'bootsnap', '>= 1.1.0', require: false

# Gives 200 OK from /ping
gem 'openstax_healthcheck'

# For installing secrets on deploy
gem "aws-sdk-ssm"

gem 'dotenv-rails'

# Exception reporting
gem 'sentry-raven'

# Profiling
gem 'scout_apm', '~> 3.0.x'

# CORS
gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  gem 'pry-rails'

  gem 'rspec-json_expectations'
  gem 'rspec-rails', '~> 3.8'

  gem 'rubocop'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'rack-mini-profiler'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
