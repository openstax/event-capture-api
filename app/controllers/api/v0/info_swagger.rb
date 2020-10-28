class Api::V0::InfoSwagger
  include Swagger::Blocks
  include OpenStax::Swagger::SwaggerBlocksExtensions

  swagger_schema :InfoData do
    property :kafka_topics do
      key :type, :array
      key :description, "Topics in the kafka cluster"
      items do
        key :type, :string
      end
    end
    property :schema_registry_subjects do
      key :type, :array
      key :description, "Subjects in the schema registry"
      items do
        key :type, :string
      end
    end
  end

  swagger_schema :InfoResults do
    property :overall_took_ms do
      key :type, :integer
      key :readOnly, true
      key :description, "How long the request took (ms)"
    end
    property :env_name do
      key :type, :string
      key :readOnly, true
      key :description, "Name of deployed environment"
    end
    property :accounts_env_name do
      key :type, :string
      key :readOnly, true
      key :description, "Accounts environment name"
    end
    property :ami_id do
      key :type, :string
      key :readOnly, true
      key :description, "Amazon machine image id"
    end
    property :git_sha do
      key :type, :string
      key :readOnly, true
      key :description, "Git sha"
    end
    property :data do
      key :'$ref', :InfoData
    end
  end

  swagger_path '/info' do
    operation :get do
      key :summary, 'Get info on event capture'
      key :description, 'Get info on event capture'
      key :operationId, 'info'
      key :produces, [
        'application/json'
      ]
      key :tags, [
        'Info'
      ]
      response 200 do
        key :description, 'Success.  Returns basic event capture metrics.'
        schema do
          key :'$ref', :InfoResults
        end
      end
      extend Api::V0::SwaggerResponses::ServerError
    end
  end
end
