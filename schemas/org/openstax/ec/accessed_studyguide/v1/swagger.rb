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
      property :source_metadata do
        key :type, :object
        key :description, 'The ids and versions needed to retrieve the original source that was interacted with'
      end
    end
  end
end
