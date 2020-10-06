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
    event_data.except(:sent_at).tap do |data|
      data[:user_uuid] = CompactUuid.pack(current_user_uuid) if current_user_uuid
      data[:occurred_at] = TimeUtil.apply_offset(normalize_at: event_data[:occurred_at], sent_at: event_data[:sent_at])
    end
  end
end
