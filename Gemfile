source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

gem 'rails', '~> 5.2.3'
gem 'puma', '~> 3.11'
gem 'bootsnap', '>= 1.1.0', require: false

# Gives 200 OK from /ping
gem 'openstax_healthcheck'

# For installing secrets on deploy
gem "aws-sdk-ssm"

gem 'dotenv-rails'

gem "openstax_auth", github: 'openstax/auth-rails', ref: 'ed2d7da86ca226b93376955b9474c4cf115c611f'

# Exception reporting
gem 'sentry-raven'

# Profiling
gem 'scout_apm', '~> 3.0.x'

# Kafka stuff
gem 'ruby-kafka'
gem 'avro_turf'
gem 'avro-builder'

# Versioned API tools
gem 'versionist'

# CORS
gem 'rack-cors'

gem "openstax_swagger", github: 'openstax/swagger-rails', ref: '9bff4962b31e142debbc62390f1fd3adab3af055'

# More concise, one-liner logs (better for production)
gem 'lograge'

group :test do
  # Code Climate integration
  # gem "codeclimate-test-reporter", require: false

  gem 'codecov', require: false
  gem 'simplecov', require: false
  gem 'sinatra'
  gem 'webmock'
end

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
