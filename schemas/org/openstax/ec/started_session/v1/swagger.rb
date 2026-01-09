module Ec::StartedSession::V1
  class Swagger
    include SwaggerEventSchema1

    swagger_event_schema(:StartedSessionV1, skip_session_fields: true, type: 'org.openstax.ec.started_session_v1') do
      key :required, [:referrer, :session_uuid]
      property :referrer do
        key :type, :string
        key :description, 'The referrer.'
      end
      property :session_uuid do
        key :type, :string
        key :description, 'The client generates this UUID and references it for all future events in this session.'
      end
      property :platform do
        key :type, :string
        key :description, 'The platform name of the app (e.g. rex, kinetic)'
      end
      property :release_id do
        key :type, :string
        key :description, 'The code version of the app.'
      end
      property :service_worker do
        key :type, :string
        key :description, 'The service worker state'
        key :enum, ['unsupported', 'inactive', 'active']
      end
      property :organization_id do
        key :type, :string
        key :description, 'The user\'s organization ID (Account ID from Salesforce)'
      end
    end
  end
end
