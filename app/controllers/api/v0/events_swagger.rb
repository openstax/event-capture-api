class Api::V0::EventsSwagger
  include Swagger::Blocks
  include OpenStax::Swagger::SwaggerBlocksExtensions

  swagger_schema :Event do
    property :data do
      key :type, :object
      key :description, 'The event payload object.  Will be of a type that lives in a swagger file inside the schemas directory.'
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
      key :summary, 'Captures events'
      key :description, 'Capture one or more events'
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
        key :required, true
        schema do
          key :'$ref', :Events
        end
      end
      response 200 do
        key :description, 'Success.'
      end
      # extend Api::V0::SwaggerResponses::AuthenticationError
      # extend Api::V0::SwaggerResponses::UnprocessableEntityError
      # extend Api::V0::SwaggerResponses::ServerError
    end
  end
end
