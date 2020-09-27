module Ec::Nudged::V1
  class Swagger
    include ::Swagger::Blocks
    include OpenStax::Swagger::SwaggerBlocksExtensions

    swagger_schema :NudgedV1 do
      key :required, [:user_uuid, :app, :target, :context, :flavor, :medium, :occurred_at_time_in_browser]
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
      property :occurred_at_time_in_browser do
        key :type, :string
        key :description, 'The unix time (ms since epoc) when nudge occurred.'
      end
      property :type do
        key :type, :string
        key :description, 'The data\'s type.'
        key :enum, ['org.openstax.ec.nudged_v1']
      end
    end
  end
end
