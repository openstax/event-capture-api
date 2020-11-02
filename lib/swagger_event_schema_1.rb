# Provides a `swagger_event_schema` alternative to `swagger_schema` that adds in some
# standard event fields.  Note that since this module will be shared among many events,
# we should not make breaking changes to it.  If there are breaking changes to be
# made, do so in a `SwaggerEventSchema2` file that you `include` in the events where
# you need those breaking changes.
module SwaggerEventSchema1

  def self.included(base)
    base.include ::Swagger::Blocks
    base.include OpenStax::Swagger::SwaggerBlocksExtensions

    base.extend(ClassMethods)
  end

  # Wraps a swagger schema, intercepting and remembering the call to set its
  # required fields
  class RequiredKeyInterceptor
    attr_reader :required_fields
    delegate_missing_to :@schema

    def initialize(schema)
      @schema = schema
      @required_fields = []
    end

    def key(key, value)
      if key.to_sym == :required
        @required_fields.push(*([value].flatten))
      else
        @schema.key(key, value)
      end
    end
  end

  module ClassMethods
    # Like `swagger_schema` but enforces a single type and adds standard event fields
    def swagger_event_schema(name, type:, &block)
      schema = swagger_schema(name) do
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
          key :enum, [type]
        end
        property :session_uuid do
          key :type, :string
          key :format, 'uuid'
          key :description, 'The session uuid.'
        end
        property :session_order do
          key :type, :integer
          key :description, 'The session order (0, 1, 2, 3...).'
        end
      end

      # Run the block on the schema (to add the event-specific fields), but use a wrapper around
      # the schema that intercepts the call to `key :required, [:blah]`.  Save off those required
      # fields and then add our three common event fields to it, and make all of those required
      # on the schema.
      wrapper = RequiredKeyInterceptor.new(schema)
      wrapper.instance_eval(&block)
      schema.key(:required, wrapper.required_fields + [:client_clock_sent_at,
                                                       :client_clock_occurred_at,
                                                       :type,
                                                       :session_uuid,
                                                       :session_order])
      schema
    end
  end
end
