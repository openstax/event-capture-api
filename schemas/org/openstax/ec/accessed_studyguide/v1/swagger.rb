module Ec::AccessedStudyguide::V1
  class Swagger
    include SwaggerEventSchema1

    swagger_event_schema(:AccessedStudyguideV1, type: 'org.openstax.ec.accessed_studyguide_v1') do
      key :required, [:user_uuid, :page_id]
      property :user_uuid do
        key :type, :object
        key :format, 'uuid'
        key :description, 'The User uuid.  Identifies the user in accounts.'
      end
      property :page_id do
        key :type, :string
        key :description, 'The book or page id.'
      end
    end
  end
end
