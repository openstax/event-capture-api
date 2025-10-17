# Load the Rails application.
require_relative "application"

if Rails.env.development? || Rails.env.test?
  require 'gem_debugger'
end

require 'errors'
require 'rescue_from_unless_local'
require 'swagger_event_schema_1'
require 'v0_bindings_extensions'

# Initialize the Rails application.
Rails.application.initialize!
