module Ec::StartedSession::V1
  class Swagger
    include SwaggerEventSchema1

    swagger_event_schema(:StartedSessionV1, skip_session_fields: true, type: 'org.openstax.ec.started_session_v1') do
      key :required, [:ip_address, :referrer, :user_agent]
      property :ip_address do
        key :type, :string
        key :description, 'The session IP address.'
      end
      property :referrer do
        key :type, :string
        key :description, 'The referrer.'
      end
      property :user_agent do
        key :type, :string
        key :description, 'The user agent.'
      end
      property :session_uuid do
        key :type, :string
        key :description, 'The client generates this UUID and references it for all future events in this session.'
      end
    end
  end
end
