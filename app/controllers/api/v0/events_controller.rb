# frozen_string_literal: true

class Api::V0::EventsController < Api::V0::BaseController
  # Errors that mean one event's data can't be stored. Resending won't fix them, so the event is
  # reported and skipped, and the rest of its batch still goes to Kafka.
  REJECTED_EVENT_ERRORS = [Avro::SchemaValidator::ValidationError, URI::InvalidURIError].freeze

  def create
    inbound_binding, error = bind(params.extract!(:events), Api::V0::Bindings::Events)
    render(json: error, status: error.status_code) and return if error

    inbound_binding.events.each do |event|
      produce(event)
    rescue *REJECTED_EVENT_ERRORS => e
      Raven.capture_exception(e, extra: { event_type: event.data.type })
    end

    render nothing: true, status: 201
  end

  private

  def produce(event)
    raw_kafka_data = KafkaData.new(api_data: event.data, controller: self)

    avro_kafka_data = KafkaAvroTurf.instance.encode(raw_kafka_data,
                                                    schema_name: raw_kafka_data.schema_name,
                                                    validate: true)

    kafka_topic = TopicsConfig.get_topic_for_event(event)
    KafkaClient.async_produce(data: avro_kafka_data, topic: kafka_topic)
  end

  class KafkaData < HashWithIndifferentAccess
    attr_reader :schema_name

    def initialize(api_data:, controller:)
      super()

      api_data = api_data.to_hash

      @controller = controller
      @schema_name = api_data.delete(:type)

      merge!(api_data)

      stringify_map_values
      translate_started_session
      translate_source_uri
      translate_uuids
      fixup_timestamps
    end

    protected

    # The schema's map<string> fields. Clients send numbers and booleans in them (listIndex: 2).
    STRING_MAP_FIELDS = %i[target_attributes context_attributes].freeze

    # What URI() rejects: anything outside RFC 3986, "[" and "]" outside an IPv6 host, and a "%"
    # that doesn't start an escape.
    URI_CHARACTERS_TO_ESCAPE = %r{[^A-Za-z0-9\-._~:/?#@!$&'()*+,;=%]|%(?!\h\h)}.freeze

    attr_reader :controller

    def stringify_map_values
      STRING_MAP_FIELDS.each do |field|
        next unless self[field].is_a?(Hash)

        self[field] = self[field].compact.transform_values do |value|
          value.is_a?(String) ? value : value.to_json
        end
      end
    end

    def translate_started_session
      # Capture request-level data for session starts
      return unless schema_name.include?('org.openstax.ec.started_session')

      self[:ip_address] = controller.request.remote_ip
      self[:user_agent] = controller.request.headers['User-Agent']
    end

    def translate_source_uri
      # Split source_uri into parts
      # URI translates anything other than nil, and the swagger schema requires
      # source_uri to be non-nil - query might be nil, though

      source_uri = parse_uri(delete(:source_uri))

      merge!({
               scheme: source_uri.scheme,
               host: source_uri.host,
               path: source_uri.path,
               query: source_uri.query ? CGI.parse(source_uri.query) : nil
             })
    end

    # Pages opened from links pasted out of chat answers arrive with extra characters attached
    # (".../6-1-exponential-functions](https://...)"). Escape them so the event keeps its page.
    def parse_uri(uri)
      URI(uri)
    rescue URI::InvalidURIError
      URI(uri.strip.gsub(URI_CHARACTERS_TO_ESCAPE) { |char| char.bytes.map { |byte| format('%%%02X', byte) }.join })
    end

    def translate_uuids
      # Set the user uuid according to the currently logged in user
      self[:user_uuid] = CompactUuid.pack(controller.current_user_uuid) if controller.current_user_uuid
      self[:device_uuid] = CompactUuid.pack(controller.current_device_uuid) if controller.current_device_uuid
      self[:session_uuid] = CompactUuid.pack(self[:session_uuid])
      
      # Need to fixup uuids in the source_metadata subschemas as well - 
      # Should read the avro-schema and do this for all that are defined as uuid but ... for now
      if self[:source_metadata]
        self[:source_metadata][:content_id] = CompactUuid.pack(self[:source_metadata][:content_id]) if self[:source_metadata][:content_id]
        self[:source_metadata][:scope_id] = CompactUuid.pack(self[:source_metadata][:scope_id]) if self[:source_metadata][:scope_id]
      end
    end

    def fixup_timestamps
      # Adjust the client's occurred at time by a device sent at adjustment
      sent_at = delete(:client_clock_sent_at)
      occurred_at = delete(:client_clock_occurred_at)

      self[:occurred_at] = DateTimeUtil.infer_actual_occurred_at_from_client_timestamps(
        request_received_at: controller.request.env[:received_at],
        client_clock_occurred_at: occurred_at,
        client_clock_sent_at: sent_at
      ).floored_milliseconds_since_epoch
    end
  end
end
