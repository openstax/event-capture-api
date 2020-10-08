module Ec::AccessStudyguide::V1
  class Swagger
    include ::Swagger::Blocks
    include OpenStax::Swagger::SwaggerBlocksExtensions

    swagger_schema :AccessStudyguideV1 do
      key :required, [:user_uuid, :page_id, :client_clock_occurred_at, :client_clock_sent_at, :type]
      property :user_uuid do
        key :type, :object
        key :format, 'uuid'
        key :description, 'The User uuid.  Identifies the user in accounts.'
      end
      property :page_id do
        key :type, :string
        key :description, 'The book or page id.'
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
        key :enum, ['org.openstax.ec.nudged_v1', 'org.openstax.ec.access_studyguide_v1']
      end
    end
  end
end
