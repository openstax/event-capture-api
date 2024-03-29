=begin
#OpenStax Event Capture API

#The Event Capture API for OpenStax.  Requests to this API should include `application/json` in the `Accept` header.  The desired API version is specified in the request URL, e.g. `[domain]/api/v0`. While the API does support a default version, that version will change over time and therefore should not be used in production code! 

OpenAPI spec version: 0.1.0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 2.4.15

=end

require 'date'

module Api::V0::Bindings
  class InteractedElementV1
    # The RFC 3339 section 5.6 date-time when event actually occurred.
    attr_accessor :client_clock_occurred_at

    # The RFC 3339 section 5.6 date-time when event was sent to the server.
    attr_accessor :client_clock_sent_at

    # The data's type.
    attr_accessor :type

    # client location when event occurred.
    attr_accessor :source_uri

    # The UUID of the current session, previously generated by the client and submitted in a \"session started\" event.
    attr_accessor :session_uuid

    # The event's numerical order within this session. E.g. the first event after a session is started should give 0 for this field, the next one should give 1, etc.
    attr_accessor :session_order

    # The target element id.
    attr_accessor :target_id

    # The target element (interactive) type.
    attr_accessor :target_type

    # The target element attributes (map, all attributes).
    attr_accessor :target_attributes

    # The target element state change that triggered event, if any.
    attr_accessor :target_state_change

    # The context element id for the target element (likely a parent: eg: if target is a solution, context would be problem).
    attr_accessor :context_id

    # The context element (parent) type.
    attr_accessor :context_type

    # The context element attributes (map, all useful attributes).
    attr_accessor :context_attributes

    # The UX region the context element is in (e.g. toc, header, page).
    attr_accessor :context_region

    attr_accessor :source_metadata

    class EnumAttributeValidator
      attr_reader :datatype
      attr_reader :allowable_values

      def initialize(datatype, allowable_values)
        @allowable_values = allowable_values.map do |value|
          case datatype.to_s
          when /Integer/i
            value.to_i
          when /Float/i
            value.to_f
          else
            value
          end
        end
      end

      def valid?(value)
        !value || allowable_values.include?(value)
      end
    end

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'client_clock_occurred_at' => :'client_clock_occurred_at',
        :'client_clock_sent_at' => :'client_clock_sent_at',
        :'type' => :'type',
        :'source_uri' => :'source_uri',
        :'session_uuid' => :'session_uuid',
        :'session_order' => :'session_order',
        :'target_id' => :'target_id',
        :'target_type' => :'target_type',
        :'target_attributes' => :'target_attributes',
        :'target_state_change' => :'target_state_change',
        :'context_id' => :'context_id',
        :'context_type' => :'context_type',
        :'context_attributes' => :'context_attributes',
        :'context_region' => :'context_region',
        :'source_metadata' => :'source_metadata'
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        :'client_clock_occurred_at' => :'DateTime',
        :'client_clock_sent_at' => :'DateTime',
        :'type' => :'String',
        :'source_uri' => :'String',
        :'session_uuid' => :'String',
        :'session_order' => :'Integer',
        :'target_id' => :'String',
        :'target_type' => :'String',
        :'target_attributes' => :'Object',
        :'target_state_change' => :'String',
        :'context_id' => :'String',
        :'context_type' => :'String',
        :'context_attributes' => :'Object',
        :'context_region' => :'String',
        :'source_metadata' => :'AccessedStudyguideV1SourceMetadata'
      }
    end

    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      if attributes.has_key?(:'client_clock_occurred_at')
        self.client_clock_occurred_at = attributes[:'client_clock_occurred_at']
      end

      if attributes.has_key?(:'client_clock_sent_at')
        self.client_clock_sent_at = attributes[:'client_clock_sent_at']
      end

      if attributes.has_key?(:'type')
        self.type = attributes[:'type']
      end

      if attributes.has_key?(:'source_uri')
        self.source_uri = attributes[:'source_uri']
      end

      if attributes.has_key?(:'session_uuid')
        self.session_uuid = attributes[:'session_uuid']
      end

      if attributes.has_key?(:'session_order')
        self.session_order = attributes[:'session_order']
      end

      if attributes.has_key?(:'target_id')
        self.target_id = attributes[:'target_id']
      end

      if attributes.has_key?(:'target_type')
        self.target_type = attributes[:'target_type']
      end

      if attributes.has_key?(:'target_attributes')
        self.target_attributes = attributes[:'target_attributes']
      end

      if attributes.has_key?(:'target_state_change')
        self.target_state_change = attributes[:'target_state_change']
      end

      if attributes.has_key?(:'context_id')
        self.context_id = attributes[:'context_id']
      end

      if attributes.has_key?(:'context_type')
        self.context_type = attributes[:'context_type']
      end

      if attributes.has_key?(:'context_attributes')
        self.context_attributes = attributes[:'context_attributes']
      end

      if attributes.has_key?(:'context_region')
        self.context_region = attributes[:'context_region']
      end

      if attributes.has_key?(:'source_metadata')
        self.source_metadata = attributes[:'source_metadata']
      end
    end

    # Show invalid properties with the reasons. Usually used together with valid?
    # @return Array for valid properties with the reasons
    def list_invalid_properties
      invalid_properties = Array.new
      if @client_clock_occurred_at.nil?
        invalid_properties.push('invalid value for "client_clock_occurred_at", client_clock_occurred_at cannot be nil.')
      end

      if @client_clock_sent_at.nil?
        invalid_properties.push('invalid value for "client_clock_sent_at", client_clock_sent_at cannot be nil.')
      end

      if @type.nil?
        invalid_properties.push('invalid value for "type", type cannot be nil.')
      end

      if @source_uri.nil?
        invalid_properties.push('invalid value for "source_uri", source_uri cannot be nil.')
      end

      if @session_uuid.nil?
        invalid_properties.push('invalid value for "session_uuid", session_uuid cannot be nil.')
      end

      if @session_order.nil?
        invalid_properties.push('invalid value for "session_order", session_order cannot be nil.')
      end

      if @target_id.nil?
        invalid_properties.push('invalid value for "target_id", target_id cannot be nil.')
      end

      if @target_type.nil?
        invalid_properties.push('invalid value for "target_type", target_type cannot be nil.')
      end

      if @target_attributes.nil?
        invalid_properties.push('invalid value for "target_attributes", target_attributes cannot be nil.')
      end

      if @context_id.nil?
        invalid_properties.push('invalid value for "context_id", context_id cannot be nil.')
      end

      if @context_type.nil?
        invalid_properties.push('invalid value for "context_type", context_type cannot be nil.')
      end

      if @context_attributes.nil?
        invalid_properties.push('invalid value for "context_attributes", context_attributes cannot be nil.')
      end

      invalid_properties
    end

    # Check to see if the all the properties in the model are valid
    # @return true if the model is valid
    def valid?
      return false if @client_clock_occurred_at.nil?
      return false if @client_clock_sent_at.nil?
      return false if @type.nil?
      type_validator = EnumAttributeValidator.new('String', ['org.openstax.ec.interacted_element_v1'])
      return false unless type_validator.valid?(@type)
      return false if @source_uri.nil?
      return false if @session_uuid.nil?
      return false if @session_order.nil?
      return false if @target_id.nil?
      return false if @target_type.nil?
      return false if @target_attributes.nil?
      return false if @context_id.nil?
      return false if @context_type.nil?
      return false if @context_attributes.nil?
      true
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] type Object to be assigned
    def type=(type)
      validator = EnumAttributeValidator.new('String', ['org.openstax.ec.interacted_element_v1'])
      unless validator.valid?(type)
        fail ArgumentError, 'invalid value for "type", must be one of #{validator.allowable_values}.'
      end
      @type = type
    end

    # Checks equality by comparing each attribute.
    # @param [Object] Object to be compared
    def ==(o)
      return true if self.equal?(o)
      self.class == o.class &&
          client_clock_occurred_at == o.client_clock_occurred_at &&
          client_clock_sent_at == o.client_clock_sent_at &&
          type == o.type &&
          source_uri == o.source_uri &&
          session_uuid == o.session_uuid &&
          session_order == o.session_order &&
          target_id == o.target_id &&
          target_type == o.target_type &&
          target_attributes == o.target_attributes &&
          target_state_change == o.target_state_change &&
          context_id == o.context_id &&
          context_type == o.context_type &&
          context_attributes == o.context_attributes &&
          context_region == o.context_region &&
          source_metadata == o.source_metadata
    end

    # @see the `==` method
    # @param [Object] Object to be compared
    def eql?(o)
      self == o
    end

    # Calculates hash code according to all attributes.
    # @return [Fixnum] Hash code
    def hash
      [client_clock_occurred_at, client_clock_sent_at, type, source_uri, session_uuid, session_order, target_id, target_type, target_attributes, target_state_change, context_id, context_type, context_attributes, context_region, source_metadata].hash
    end

    # Builds the object from hash
    # @param [Hash] attributes Model attributes in the form of hash
    # @return [Object] Returns the model itself
    def build_from_hash(attributes)
      return nil unless attributes.is_a?(Hash)
      self.class.swagger_types.each_pair do |key, type|
        if type =~ /\AArray<(.*)>/i
          # check to ensure the input is an array given that the attribute
          # is documented as an array but the input is not
          if attributes[self.class.attribute_map[key]].is_a?(Array)
            self.send("#{key}=", attributes[self.class.attribute_map[key]].map { |v| _deserialize($1, v) })
          end
        elsif !attributes[self.class.attribute_map[key]].nil?
          self.send("#{key}=", _deserialize(type, attributes[self.class.attribute_map[key]]))
        end # or else data not found in attributes(hash), not an issue as the data can be optional
      end

      self
    end

    # Deserializes the data based on type
    # @param string type Data type
    # @param string value Value to be deserialized
    # @return [Object] Deserialized data
    def _deserialize(type, value)
      case type.to_sym
      when :DateTime
        DateTime.parse(value)
      when :Date
        Date.parse(value)
      when :String
        value.to_s
      when :Integer
        value.to_i
      when :Float
        value.to_f
      when :BOOLEAN
        if value.to_s =~ /\A(true|t|yes|y|1)\z/i
          true
        else
          false
        end
      when :Object
        # generic object (usually a Hash), return directly
        value
      when /\AArray<(?<inner_type>.+)>\z/
        inner_type = Regexp.last_match[:inner_type]
        value.map { |v| _deserialize(inner_type, v) }
      when /\AHash<(?<k_type>.+?), (?<v_type>.+)>\z/
        k_type = Regexp.last_match[:k_type]
        v_type = Regexp.last_match[:v_type]
        {}.tap do |hash|
          value.each do |k, v|
            hash[_deserialize(k_type, k)] = _deserialize(v_type, v)
          end
        end
      else # model
        temp_model = Api::V0::Bindings.const_get(type).new
        temp_model.tap{|tm| tm.build_from_hash(value)}
      end
    end

    # Returns the string representation of the object
    # @return [String] String presentation of the object
    def to_s
      to_hash.to_s
    end

    # to_body is an alias to to_hash (backward compatibility)
    # @return [Hash] Returns the object in the form of hash
    def to_body
      to_hash
    end

    # Returns the object in the form of hash
    # @return [Hash] Returns the object in the form of hash
    def to_hash
      hash = {}
      self.class.attribute_map.each_pair do |attr, param|
        value = self.send(attr)
        next if value.nil?
        hash[param] = _to_hash(value)
      end
      hash
    end

    # Outputs non-array value in the form of hash
    # For object, use to_hash. Otherwise, just return the value
    # @param [Object] value Any valid value
    # @return [Hash] Returns the value in the form of hash
    def _to_hash(value)
      if value.is_a?(Array)
        value.compact.map { |v| _to_hash(v) }
      elsif value.is_a?(Hash)
        {}.tap do |hash|
          value.each { |k, v| hash[k] = _to_hash(v) }
        end
      elsif value.respond_to? :to_hash
        value.to_hash
      else
        value
      end
    end

  end
end
