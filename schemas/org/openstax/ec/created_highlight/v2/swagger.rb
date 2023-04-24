module Ec::CreatedHighlight::V2
  class Swagger
    include SwaggerEventSchema1

    swagger_event_schema(:CreatedHighlightV2, type: 'org.openstax.ec.created_highlight_v2') do
      key :required, [:highlight_id, :source_type, :source_metadata, :anchor, :color, :location_strategies]
      property :highlight_id do
        key :type, :string
        key :description, 'The highlight id.'
      end
      property :source_type do
        key :type, :string
        key :description, 'The highlight source type (e.g., openstax_page).'
      end
      property :anchor do
        key :type, :string
        key :description, 'The highlight anchor.'
      end
      property :color do
        key :type, :string
        key :description, 'The highlight color.'
      end
      property :location_strategies do
        key :type, :string
        key :description, 'The highlight location strategies (e.g., a text position selector).'
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
