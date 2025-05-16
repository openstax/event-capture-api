class Api::V0::EventsSwagger
  include Swagger::Blocks
  include OpenStax::Swagger::SwaggerBlocksExtensions

  swagger_schema :Event do
    key :required, [:data]
    property :data do
      key :type, :object
      key :description, 'The event object.  Will be of a type that lives in a swagger file inside the schemas directory.'
    end
  end

  swagger_schema :Events do
    property :events do
      key :type, :array
      key :description, 'Array of Event'
      items do
        key :'$ref', :Event
      end
    end
  end

  swagger_path '/events' do
    operation :post do
      key :summary, 'Captures events'
      key :description, 'Capture one or more events'
      key :operationId, 'addEvents'
      key :produces, [
        'application/json'
      ]
      key :tags, [
        'Events'
      ]
      parameter do
        key :name, :payload # ignored but used in various ways in client generation
        key :in, :body
        key :required, true
        schema do
          key :'$ref', :Events
        end
      end
      parameter do
        key :name, :Authorization
        key :in, :header
        key :description, 'Optional Authorization header (defaults to Cookie if absent)'
        key :required, false
        key :type, :string
      end
      response 201 do
        key :description, 'Created.'
      end
      # extend Api::V0::SwaggerResponses::AuthenticationError
      # extend Api::V0::SwaggerResponses::UnprocessableEntityError
      # extend Api::V0::SwaggerResponses::ServerError
    end
  end
end
