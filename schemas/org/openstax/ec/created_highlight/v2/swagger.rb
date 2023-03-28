module Ec::CreatedHighlight::V2
  class Swagger
    include SwaggerEventSchema1

    swagger_event_schema(:CreatedHighlightV2, type: 'org.openstax.ec.created_highlight_v2') do
      key :required, [:highlight_id, :source_type, :source_metadata, :anchor, :annotation, :color, :location_strategies]
      property :highlight_id do
        key :type, :string
        key :description, 'The highlight id.'
      end
      property :source_type do
        key :type, :string
        key :description, 'The highlight source type (e.g., openstax_page).'
      end
      property :source_metadata do
        key :type, :object
        key :description, 'The highlight source metadata.'
      end
      property :annotation do
        key :type, :string
        key :description, 'The highlight annotation.'
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
    end
  end
end
