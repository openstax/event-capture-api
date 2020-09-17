class Ec::Nudged::V1::NudgedSwagger
  include Swagger::Blocks
  include OpenStax::Swagger::SwaggerBlocksExtensions

  swagger_schema :Nudged do
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
      key :description, 'The data object type. Used to locate the datum and swagger schemas.'
      key :description, <<~DESC
        The data object type. Used to locate the datum and swagger schemas

        This type will be prepended to '.v<version>' and suffixed with the last
        portion of the type to create the full length datum schema name used by 
        datum turf to locate the datum schema in the API's code repository.  

        e.g., for version == 1, the full (avroturf) schema name would be built as
           'org.openstax.ec.nudged.v1.nudged'
      DESC

      key :default, 'org.openstax.ec.nudged'
    end
    property :version do
      key :type, :integer
      key :description, 'The data object version. Used to locate the datum and swagger schemas. See details in the type description.'
      key :default, 1
    end
  end

end
