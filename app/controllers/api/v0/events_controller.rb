# frozen_string_literal: true

class Api::V0::EventsController < Api::V0::BaseController
  def create
    inbound_binding, error = bind(params.extract!(:events), Api::V0::Bindings::Events)
    render(json: error, status: error.status_code) and return if error

    inbound_binding.events.each do |event|
      raw_kafka_data = KafkaData.new(api_data: event.data, controller: self)

      avro_kafka_data = KafkaAvroTurf.instance.encode(raw_kafka_data,
                                                      schema_name: raw_kafka_data.schema_name,
                                                      validate: true)

      kafka_topic = TopicsConfig.get_topic_for_event(event)
      KafkaClient.async_produce(data: avro_kafka_data, topic: kafka_topic)
    end

    render nothing: true, status: 201
  end

  class KafkaData < HashWithIndifferentAccess
    attr_reader :schema_name

    def initialize(api_data:, controller:)
      super()

      api_data = api_data.to_hash

      @controller = controller
      @schema_name = api_data.delete(:type)

      merge!(api_data)

      translate_started_session
      translate_source_uri
      translate_uuids
      fixup_timestamps
    end

    protected

    attr_reader :controller

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

      source_uri = URI(delete(:source_uri))

      merge!({
               scheme: source_uri.scheme,
               host: source_uri.host,
               path: source_uri.path,
               query: source_uri.query ? CGI.parse(source_uri.query) : nil
             })
    end

    def translate_uuids
      # Set the user uuid according to the currently logged in user
      self[:user_uuid] = CompactUuid.pack(controller.current_user_uuid) if controller.current_user_uuid
      self[:device_uuid] = CompactUuid.pack(controller.current_device_uuid) if controller.current_device_uuid
      self[:session_uuid] = CompactUuid.pack(self[:session_uuid])
    end

    def fixup_timestamps
      # Adjust the client's occurred at time by a device sent at adjustment
      sent_at = delete(:client_clock_sent_at)
      occurred_at = delete(:client_clock_occurred_at)

      # Schema expects integer timestamps in milliseconds
      self[:occurred_at] = (TimeUtil.infer_actual_occurred_at_from_client_timestamps(
        request_received_at: controller.request.env[:received_at],
        client_clock_occurred_at: occurred_at,
        client_clock_sent_at: sent_at
      ).to_f * 1000).to_i
    end
  end
end
