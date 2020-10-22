module Ec::CreatedHighlight::V1
  class Swagger
    include SwaggerEventSchema1

    swagger_event_schema(:CreatedHighlightV1, type: 'org.openstax.ec.created_highlight_v1') do
      key :required, [:user_uuid, :contents, :location, :color]
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
    end
  end
end
