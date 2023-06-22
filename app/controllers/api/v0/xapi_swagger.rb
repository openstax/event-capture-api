class Api::V0::XapiSwagger
  include Swagger::Blocks
  include OpenStax::Swagger::SwaggerBlocksExtensions

  swagger_schema :Actor do
    key :type, :object
    key :required, [:name]
    property :name do
      key :type, :string
      key :description, 'The name of the actor.'
    end
    property :account do
      key :type, :object
      key :required, [:homePage, :name]
      property :homePage do
        key :type, :string
        key :description, 'The URL of the actor\'s home page.'
      end
      property :name do
        key :type, :string
        key :description, 'The account name or handle.'
      end
    end
  end

  swagger_schema :Verb do
    key :type, :object
    key :required, [:id]
    property :id do
      key :type, :string
      key :description, 'The unique identifier of the verb.'
    end
    property :display do
      key :type, :object
      key :required, [:en]
      property :en do
        key :type, :string
        key :description, 'The verb display name in English.'
      end
      # Add other language properties as needed
    end
  end

  swagger_schema :Object do
    key :type, :object
    key :required, [:id]
    property :id do
      key :type, :string
      key :description, 'The unique identifier of the object.'
    end
    property :definition do
      key :type, :object
      property :name do
        key :type, :object
        key :required, [:en]
        property :en do
          key :type, :string
          key :description, 'The object display name in English.'
        end
      end
    end
  end

  swagger_schema :Result do
    key :type, :object
    property :score do
      key :type, :object
      key :required, [:raw]
      property :raw do
        key :type, :number
        key :description, 'The raw score value.'
      end
    end
  end

  swagger_schema :Statement do
    key :type, :object
    key :required, [:actor, :verb, :object]
    property :id do
      key :type, :string
      key :description, 'The unique identifier of the statement.'
    end
    property :actor do
      key :'$ref', :Actor
      key :description, 'The actor who performed the action described in the statement.'
    end
    property :verb do
      key :'$ref', :Verb
      key :description, 'The action performed by the actor.'
    end
    property :object do
      key :'$ref', :Object
      key :description, 'The object or target of the action.'
    end
    property :context do
      key :'$ref', :Context
      key :description, 'The context in which the statement occurred.'
    end
    property :result do
      key :'$ref', :Result
      key :description, 'The result or outcome of the action.'
    end
    property :timestamp do
      key :type, :string
      key :format, :date_time
      key :description, 'The timestamp when the statement was made.'
    end
    property :attachments do
      key :type, :array
      items do
        key :'$ref', :Attachment
      end
      key :description, 'Any attachments associated with the statement.'
    end
    property :authority do
      key :'$ref', :Agent
      key :description, 'The authority or source of the statement.'
    end
    property :version do
      key :type, :string
      key :description, 'The version of the xAPI specification.'
    end
  end

  swagger_schema :Statements do
    property :statements do
      key :type, :array
      key :description, 'Array of Statement'
      items do
        key :'$ref', :Statement
      end
    end
  end

  swagger_path '/xapi/statements' do
    operation :put do
      key :summary, 'Stores a single Statement with the given id.'
      key :description, 'Stores a single `Statement` with the given id. POST can also be used to store single Statements.'
      parameter do
        key :name, 'method'
        key :in, 'query'
        key :type, 'string'
        key :description, 'a MUST'
        key :default, 'PUT'
        key :required, true
      end
      parameter do
        key :name, 'statementId'
        key :type, 'string'
        key :in, 'query'
        key :description, 'Id of Statement to record'
        key :required, true
      end
      parameter do
        key :name, 'content'
        key :in, 'body'
        key :required, true
        schema do
          key :'$ref', :Statement
        end
      end
      response '204' do
        key :description, 'Default response'
        header 'X-Experience-API-Consistent-Through' do
          key :type, 'string'
          key :format, 'date-time'
          key :description, 'The LRS MUST include this header on all responses to Statements Resource requests.'
        end
      end
      response '409' do
        key :description, 'If the LRS receives a Statement with an id it already has a Statement for, it SHOULD verify the received Statement matches the existing one and SHOULD return 409 Conflict if they do not match. See Statement comparison requirements.'
        header 'X-Experience-API-Consistent-Through' do
          key :type, 'string'
          key :format, 'date-time'
          key :description, 'The LRS MUST include the header "X-Experience-API-Consistent-Through" on all responses to Statements Resource requests.'
        end
      end
      response '400' do
        key :description, 'If the LRS receives a batch of Statements containing two or more Statements with the same id, it SHOULD* reject the batch and return 400 Bad Request.'
        header 'X-Experience-API-Consistent-Through' do
          key :type, 'string'
          key :format, 'date-time'
          key :description, 'The LRS MUST include the header "X-Experience-API-Consistent-Through" on all responses to Statements Resource requests.'
        end
      end
    end

    operation :post do
      key :summary, 'Stores a Statement, or a set of Statements.'
      key :description, 'Stores a Statement, or a set of Statements.'
      parameter do
        key :name, 'content'
        key :in, :body
        key :required, true
        schema do
          key :type, :array
          items do
            key :'$ref', :Statement
          end
        end
      end
      response '204' do
        key :description, 'Default response'
        header 'X-Experience-API-Consistent-Through' do
          key :type, :string
          key :format, :'date-time'
          key :description, 'The LRS MUST include the header "X-Experience-API-Consistent-Through" on all responses to Statements Resource requests.'
        end
      end
      response '400' do
        key :description, 'If the LRS receives a batch of Statements containing two or more Statements with the same id, it SHOULD* reject the batch and return 400 Bad Request.'
        header 'X-Experience-API-Consistent-Through' do
          key :type, :string
          key :format, :'date-time'
          key :description, 'The LRS MUST include the header "X-Experience-API-Consistent-Through" on all responses to Statements Resource requests.'
        end
      end
    end
  end
end

