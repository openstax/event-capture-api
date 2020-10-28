require 'uri'

class Api::V0::SwaggerController < ApplicationController
  include ::Swagger::Blocks

  ACCEPT_HEADER = 'application/json'
  BASE_PATH = '/api/v0/events'

  swagger_root do
    key :swagger, '2.0'
    info do
      key :version, '0.1.0'
      key :title, 'OpenStax Event Capture API'
      key :description, <<~DESC
        The Event Capture API for OpenStax.

        Requests to this API should include `#{ACCEPT_HEADER}` in the `Accept` header.

        The desired API version is specified in the request URL, e.g. `[domain]#{BASE_PATH}`. \
        While the API does support a default version, that version will change over \
        time and therefore should not be used in production code!
      DESC
      key :termsOfService, 'https://openstax.org/tos'
      contact do
        key :name, 'support@openstax.org'
      end
      license do
        key :name, 'MIT'
      end
    end
    tag do
      key :name, 'Event Capture'
      key :description, 'Event Capture endpoints'
    end
    key :basePath, BASE_PATH
    key :consumes, [ACCEPT_HEADER]
    key :produces, ['application/json']
  end

  def self.swagger_classes
    list = [
      Api::V0::SwaggerResponses,
      Api::V0::EventsSwagger,
      Api::V0::InfoSwagger,
      self
    ]
    # dyamically add the event swagger, so that the client can to build the
    # correct payload for the event data. Another result is that there are two
    # levels of validation: incoming in swagger, and thru avro schema validation.
    list.concat(SwaggerFinder.new.classes)
  end

  def json
    render json: Swagger::Blocks.build_root_json(self.class.swagger_classes)
  end
end
