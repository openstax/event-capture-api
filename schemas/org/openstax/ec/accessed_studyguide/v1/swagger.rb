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
        key :required, [:content_id, :content_version]
        property :content_id do
          key :type, :string
          key :description, 'ID of content visible when this event occurred.'
        end
        property :content_version do
          key :type, :string
          key :description, 'Version of the content'
        end
        property :context_version do
          key :type, :string
          key :description, 'Version that impacts the source content, but is not revision of the content itself, such as a versioned api, or content pipeline'
        end
        property :content_index do
          key :type, :integer
          key :description, 'Zero based index of this content in its parent list, if any exists.'
        end
        property :scope_id do
          key :type, :string
          key :description, 'ID for the larger scope of this content'
        end
      end
    end
  end
end
