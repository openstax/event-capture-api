module Ec::InteractedElement::V1
  class Swagger
    include SwaggerEventSchema1

    swagger_event_schema(:InteractedElementV1, type: 'org.openstax.ec.interacted_element_v1') do
      key :required, [:target_id, :target_type, :target_attributes, :context_id, :context_type, :context_attributes ]
      property :target_id do
        key :type, :string
        key :description, 'The target element id.'
      end
      property :target_type do
        key :type, :string
        key :description, 'The target element (interactive) type.'
      end
      property :target_attributes do
        key :type, :object
        key :description, 'The target element attributes (map, all attributes).'
      end
      property :target_state_change do
        key :type, :string
        key :description, 'The target element state change that triggered event, if any.'
      end
      property :context_id do
        key :type, :string
        key :description, 'The context element id for the target element (likely a parent: eg: if target is a solution, context would be problem).'
      end
      property :context_type do
        key :type, :string
        key :description, 'The context element (parent) type.'
      end
      property :context_attributes do
        key :type, :object
        key :description, 'The context element attributes (map, all useful attributes).'
      end
      property :context_region do
        key :type, :string
        key :description, 'The UX region the context element is in (e.g. toc, header, page).'
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
