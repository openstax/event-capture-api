# frozen_string_literal: true

class Api::V0::EventsController < Api::V0::BaseController
  def create
    inbound_binding, error = bind(params.extract!(:events), Api::V0::Bindings::Events)
    render(json: error, status: error.status_code) and return if error

    inbound_binding.events.each do |event|
      avro_data = patch_data(event_data: event.data.to_hash)
      avro_encoded_data = KafkaAvroTurf.instance.encode(avro_data, schema_name: event.data.type)

      KafkaClient.async_produce(data: avro_encoded_data, topic: event.topic)
    end

    render nothing: true, status: 201
  end

  private

  def patch_data(event_data:)
    event_data.except(:client_clock_sent_at).tap do |data|
      # Set the user uuid according to the currently logged in user
      data[:user_uuid] = CompactUuid.pack(current_user_uuid) if current_user_uuid

      # Adjust the client's occurred at time by a device sent at adjustment
      data[:occurred_at] = TimeUtil.device_adjust(
        normalize_at: event_data[:client_clock_occurred_at],
        sent_at: event_data[:client_clock_sent_at]).to_i
    end
  end
end
