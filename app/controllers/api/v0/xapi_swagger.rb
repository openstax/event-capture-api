class Api::V0::XapiSwagger
  include Swagger::Blocks
  include OpenStax::Swagger::SwaggerBlocksExtensions

  swagger_schema :Statement do
    key :required, [:id, :actor, :verb, :object]
    property :id do
      key :type, :string
    end
    property :actor do
      key :oneOf, [
        { '$ref': :Agent },
        { '$ref': :Group }
      ]
    end
    property :verb do
      key :'$ref', :Verb
    end
    property :object do
      key :oneOf, [
        { '$ref': :Activity },
        { '$ref': :Agent },
        { '$ref': :StatementRef },
        { '$ref': :SubStatement }
      ]
    end
    property :result do
      key :'$ref', :Result
    end
    property :context do
      key :'$ref', :Context
    end
    property :timestamp do
      key :type, :string
    end
    property :stored do
      key :type, :string
    end
    property :authority do
      key :'$ref', :Agent
    end
    property :version do
      key :type, :string
    end
    property :attachments do
      key :type, :array
      items do
        key :'$ref', :Attachment
      end
    end
  end

  swagger_schema :SubStatement do
    key :required, [:actor, :verb, :object]
    property :actor do
      key :oneOf, [
        { '$ref': :Agent },
        { '$ref': :Group }
      ]
    end
    property :verb do
      key :'$ref', :Verb
    end
    property :object do
      key :oneOf, [
        { '$ref': :Activity },
        { '$ref': :Agent },
        { '$ref': :StatementRef }
      ]
    end
    property :result do
      key :'$ref', :Result
    end
    property :context do
      key :'$ref', :Context
    end
    property :timestamp do
      key :type, :string
    end
    property :attachments do
      key :type, :array
      items do
        key :'$ref', :Attachment
      end
    end
  end

  swagger_schema :Verb do
    key :required, [:id]
    property :id do
      key :type, :string
    end
    property :display do
      key :type, :object
    end
  end

  swagger_schema :Activity do
    key :required, [:id, :objectType]
    property :id do
      key :type, :string
    end
    property :objectType do
      key :type, :string
    end
    property :definition do
      key :'$ref', :ActivityDefinition
    end
  end

  swagger_schema :Agent do
    key :required, [:objectType]
    property :objectType do
      key :type, :string
    end
    property :name do
      key :type, :string
    end
    property :mbox do
      key :type, :string
    end
    property :mbox_sha1sum do
      key :type, :string
    end
    property :openid do
      key :type, :string
    end
    property :account do
      key :'$ref', :Account
    end
  end

  swagger_schema :StatementRef do
    key :required, [:objectType, :id]
    property :objectType do
      key :type, :string
    end
    property :id do
      key :type, :string
    end
  end

  swagger_schema :Result do
    property :score do
      key :'$ref', :Score
    end
    property :success do
      key :type, :boolean
    end
    property :completion do
      key :type, :boolean
    end
    property :response do
      key :type, :string
    end
    property :duration do
      key :type, :string
    end
    property :extensions do
      key :type, :object
    end
  end

  swagger_schema :Context do
    property :registration do
      key :type, :string
    end
    property :instructor do
      key :oneOf, [
        { '$ref': :Agent },
        { '$ref': :Group }
      ]
    end
    property :team do
      key :oneOf, [
        { '$ref': :Agent },
        { '$ref': :Group }
      ]
    end
    property :contextActivities do
      key :'$ref', :ContextActivities
    end
    property :revision do
      key :type, :string
    end
    property :platform do
      key :type, :string
    end
    property :language do
      key :type, :string
    end
    property :statement do
      key :'$ref', :StatementRef
    end
    property :extensions do
      key :type, :object
    end
  end

  swagger_schema :Attachment do
    key :required, [:usageType, :display, :description, :contentType, :length, :sha2]
    property :usageType do
      key :type, :string
    end
    property :display do
      key :type, :object
    end
    property :description do
      key :type, :object
    end
    property :contentType do
      key :type, :string
    end
    property :length do
      key :type, :integer
    end
    property :sha2 do
      key :type, :string
    end
    property :fileUrl do
      key :type, :string
    end
  end

  swagger_schema :ActivityDefinition do
    property :name do
      key :type, :object
    end
    property :description do
      key :type, :object
    end
    property :type do
      key :type, :string
    end
    property :moreInfo do
      key :type, :string
    end
    property :extensions do
      key :type, :object
    end
  end

  swagger_schema :Score do
    property :scaled do
      key :type, :number
      key :format, :double
    end
    property :raw do
      key :type, :number
      key :format, :double
    end
    property :min do
      key :type, :number
      key :format, :double
    end
    property :max do
      key :type, :number
      key :format, :double
    end
  end

  swagger_schema :Account do
    key :required, [:homePage, :name]
    property :homePage do
      key :type, :string
    end
    property :name do
      key :type, :string
    end
  end

  swagger_schema :Group do
    property :objectType do
      key :type, :string
    end
    property :name do
      key :type, :string
    end
    property :member do
      key :type, :array
      items do
        key :'$ref', :Agent
      end
    end
  end

  swagger_schema :ContextActivities do
    property :parent do
      key :type, :array
      items do
        key :'$ref', :Activity
      end
    end
    property :category do
      key :type, :array
      items do
        key :'$ref', :Activity
      end
    end
    property :other do
      key :type, :array
      items do
        key :'$ref', :Activity
      end
    end
  end
end
