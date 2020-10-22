module Ec::AccessedStudyguide::V1
  class Swagger
    include SwaggerEventSchema1

    swagger_event_schema(:AccessedStudyguideV1, type: 'org.openstax.ec.accessed_studyguide_v1') do
      key :required, [:page_id, :book_id]
      property :page_id do
        key :type, :string
        key :description, 'The page id.'
      end
      property :book_id do
        key :type, :string
        key :description, 'The book id.'
      end
    end
  end
end
