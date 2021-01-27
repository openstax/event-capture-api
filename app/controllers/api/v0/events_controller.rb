# frozen_string_literal: true

class Api::V0::EventsController < Api::V0::BaseController
  def create
    inbound_binding, error = bind(params.extract!(:events), Api::V0::Bindings::Events)
    render(json: error, status: error.status_code) and return if error

    inbound_binding.events.each do |event|
      raw_kafka_data = KafkaData.new(api_data: event.data, controller: self).to_hash
      avro_kafka_data = KafkaAvroTurf.instance.encode(raw_kafka_data, schema_name: event.data.type)

      kafka_topic = TopicsConfig.get_topic_for_event(event)
      KafkaClient.async_produce(data: avro_kafka_data, topic: kafka_topic)
    end

    render nothing: true, status: 201
  end

  class KafkaData
    def initialize(api_data:, controller:)
      @data = api_data.to_hash
      @controller = controller

      translate_started_session
      translate_source_uri
      translate_uuids
      fixup_timestamps
    end

    def to_hash
      data
    end

    protected

    attr_reader :data, :controller

    def translate_started_session
      # Capture request-level data for session starts
      return unless data[:type].include?('org.openstax.ec.started_session')
      data[:ip_address] = controller.request.remote_ip
      data[:user_agent] = request.headers['User-Agent']
    end

    def translate_source_uri
      # Split source_uri into parts
      # URI translates anything other than nil, and the swagger schema requires
      # source_uri to be non-nil
      # TODO parse query params into a hash of some sort?
      
      source_uri = URI(data[:source_uri])

      data[:scheme] = source_uri.scheme
      data[:host] = source_uri.host
      data[:path] = source_uri.path
      data[:query] = source_uri.query

      data.except!(:source_uri)
    end

    def translate_uuids
      # Set the user uuid according to the currently logged in user
      data[:user_uuid] = CompactUuid.pack(controller.current_user_uuid) if controller.current_user_uuid
      data[:device_uuid] = CompactUuid.pack(controller.current_device_uuid) if controller.current_device_uuid
      data[:session_uuid] = CompactUuid.pack(data[:session_uuid])
    end

    def fixup_timestamps
      # Adjust the client's occurred at time by a device sent at adjustment
      data[:occurred_at] = TimeUtil.infer_actual_occurred_at_from_client_timestamps(
        request_received_at: controller.request.env[:received_at],
        client_clock_occurred_at: data[:client_clock_occurred_at],
        client_clock_sent_at: data[:client_clock_sent_at]
      ).to_i

      data.except!(:client_clock_sent_at, :client_clock_occurred_at)
    end
  end
end

