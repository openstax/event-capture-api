class Api::V0::EventsSwagger
  include Swagger::Blocks
  include OpenStax::Swagger::SwaggerBlocksExtensions

  swagger_schema :Event do
    property :data do
      key :type, :object
      key :description, 'The kafka data object.  Should be of type Nudge.'
    end
    property :schema_type do
      key :type, :string
      key :description, 'The schema type of the data object. This is used for schema validation.'
    end
    property :schema_version do
      key :type, :integer
      key :description, 'The version of the schema type. This is used for schema validation.'
    end
    property :topic do
      key :type, :string
      key :description, 'The kafka topic'
    end
  end

  swagger_schema :Events do
    property :events do
      key :type, :array
      key :description, 'Array of Events'
      items do
        key :'$ref', :Event
      end
    end
  end

  swagger_path '/events' do
    operation :post do
      key :summary, 'Capture a event'
      key :description, 'Capture a event into kafka'
      key :operationId, 'addEvent'
      key :produces, [
        'application/json'
      ]
      key :tags, [
        'Events'
      ]
      parameter do
        key :name, :events
        key :in, :body
        key :description, 'The event data'
        key :required, true
        schema do
          key :'$ref', :Events
        end
      end
      response 201 do
        key :description, 'Created.  Returns the created highlight.'
      end
      # extend Api::V0::SwaggerResponses::AuthenticationError
      # extend Api::V0::SwaggerResponses::UnprocessableEntityError
      # extend Api::V0::SwaggerResponses::ServerError
    end
  end
end
