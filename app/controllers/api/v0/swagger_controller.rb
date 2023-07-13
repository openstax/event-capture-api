class Api::V0::SwaggerController < ApplicationController
  include ::Swagger::Blocks

  ACCEPT_HEADER = 'application/json'
  BASE_PATH = '/api/v0'

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

  # Used by swagger-rails to generate bindings, and our local generate_swagger_json
  # rake task
  def self.swagger_classes
    list = [
      Api::V0::SwaggerResponses,
      Api::V0::EventsSwagger,
      Api::V0::InfoSwagger,
      Api::V0::XapiSwagger,
      self
    ]
    # dyamically add the event swagger, so that the client can to build the
    # correct payload for the event data. Another result is that there are two
    # levels of validation: incoming in swagger, and thru avro schema validation.
    list.concat(SwaggerFinder.new.classes)
  end

  def json
    render json: File.read("#{Rails.root}/app/bindings/api/v0/swagger.json")
  end
end
