module Ec::ChangedSession::V1
  class Swagger
    include SwaggerEventSchema1

    swagger_event_schema(:ChangedSessionV1, type: 'org.openstax.ec.changed_session_v1') do
      key :required, [:visibility, :old_visibility ]
      property :visibility do
        key :type, :string
        key :description, 'The apps new visibility, from "visible", "hidden", or "none".'
      end
      property :old_visibility do
        key :type, :string
        key :description, 'The apps previous visibility, from "visible", "hidden", or "none".'
      end
    end
  end
end
