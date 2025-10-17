source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby File.read('.ruby-version').strip

gem 'rails', '~> 6.0.0'
gem 'puma'
gem 'bootsnap', require: false

# Gives 200 OK from /ping
gem 'openstax_healthcheck'

# For installing secrets on deploy
gem "aws-sdk-ssm"

gem 'dotenv-rails'

gem "openstax_auth"

# Exception reporting
gem 'sentry-raven'

# Profiling
gem 'scout_apm'

# Kafka stuff
gem 'ruby-kafka'
gem 'avro_turf', github: 'dasch/avro_turf', ref: '6ef7a6b5458a61a9d57307ee0bb1a7fdfb3ed170'
gem 'avro-builder'

# Versioned API tools
gem 'versionist'

# CORS
gem 'rack-cors'

gem 'openstax_swagger', github: 'openstax/swagger-rails', ref: 'c88e569861378fa858e98da55eefe6da31b121c2'

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
  gem 'rspec-rails'

  gem 'rubocop'
end

group :development do
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'

  gem 'rack-mini-profiler'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'concurrent-ruby', '1.3.4'
