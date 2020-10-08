module Ec::Nudged::V1
  class Swagger
    include ::Swagger::Blocks
    include OpenStax::Swagger::SwaggerBlocksExtensions

    swagger_schema :NudgedV1 do
      key :required, [:user_uuid, :app, :target, :context, :flavor, :medium, :occurred_at, :sent_at]
      property :user_uuid do
        key :type, :object
        key :format, 'uuid'
        key :description, 'The User uuid.  Identifies the user in accounts.'
      end
      property :app do
        key :type, :string
        key :description, 'The app sourcing the nudge (e.g., tutor.'
      end
      property :target do
        key :type, :string
        key :description, 'The target of the nudge (e.g., study_guides).'
      end
      property :context do
        key :type, :string
        key :description, 'The nudge context (e.g., a book uuid).'
      end
      property :flavor do
        key :type, :string
        key :description, 'The nudge flavor (e.g., full screen v2).'
      end
      property :medium do
        key :type, :string
        key :description, 'The nudge medium (e.g., email).'
      end
      property :client_clock_occurred_at do
        key :type, :string
        key :format, 'date-time'
        key :description, 'The RFC 3339 section 5.6 date-time when nudge actually occurred.'
      end
      property :client_clock_sent_at do
        key :type, :string
        key :format, 'date-time'
        key :description, 'The RFC 3339 section 5.6 date-time when nudge event was sent to the server.'
      end
      property :type do
        key :type, :string
        key :description, 'The data\'s type.'
        key :enum, ['org.openstax.ec.nudged_v1']
      end
    end
  end
end
