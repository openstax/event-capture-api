module Ec::ChangedState::V1
  class Swagger
    include SwaggerEventSchema1

    swagger_event_schema(:ChangedStateV1, type: 'org.openstax.ec.changed_state_v1') do
      key :required, [:state_type, :current, :previous]
      property :state_type do
        key :type, :string
        key :description, 'The type of state that is changing, e.g. visibility'
      end
      property :current do
        key :type, :string
        key :description, 'The current value for the state described by :state_type'
      end
      property :previous do
        key :type, :string
        key :description, 'The previous value for the state described by :state_type'
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
          key :type, :string
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
