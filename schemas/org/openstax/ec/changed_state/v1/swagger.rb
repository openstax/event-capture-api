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
        key :description, 'The current value for the state described by :type'
      end
      property :previous do
        key :type, :string
        key :description, 'The previous value for the state described by :type'
      end
    end
  end
end
