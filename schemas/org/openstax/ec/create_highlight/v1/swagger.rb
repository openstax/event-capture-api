module Ec::CreateHighlight::V1
  class Swagger
    include ::Swagger::Blocks
    include OpenStax::Swagger::SwaggerBlocksExtensions

    swagger_schema :CreateHighlightV1 do
      key :required, [:user_uuid, :client_clock_occurred_at, :client_clock_sent_at, :type]
      property :user_uuid do
        key :type, :object
        key :format, 'uuid'
        key :description, 'The User uuid.  Identifies the user in accounts.'
      end
      property :contents do
        key :type, :string
        key :description, 'The highlight contents.'
      end
      property :location do
        key :type, :string
        key :description, 'The highlight location (e.g., book uuid or anchor).'
      end
      property :color do
        key :type, :string
        key :description, 'The highlight color.'
      end
      property :client_clock_occurred_at do
        key :type, :string
        key :format, 'date-time'
        key :description, 'The RFC 3339 section 5.6 date-time when nudge actually occurred.'
      end
      property :client_clock_sent_at do
        key :type, :string
        key :format, 'date-time'
        key :description, 'The RFC 3339 section 5.6 date-time when nudge event was sent to the server.'
      end
      property :type do
        key :type, :string
        key :description, 'The data\'s type.'
        key :enum, ['org.openstax.ec.nudged_v1']
      end
    end
  end
end
