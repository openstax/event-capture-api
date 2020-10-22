module Ec::Nudged::V1
  class Swagger
    include SwaggerEventSchema1

    swagger_event_schema(:NudgedV1, type: 'org.openstax.ec.nudged_v1') do
      key :required, [:app, :target, :context, :flavor, :medium]
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
    end
  end
end
