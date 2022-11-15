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
    end
  end
end
