module Ec::StartedSession::V1
  class Swagger
    include SwaggerEventSchema1

    swagger_event_schema(:StartedSessionV1, type: 'org.openstax.ec.started_session_v1') do
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
    end
  end
end
