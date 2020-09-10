# frozen_string_literal: true

class Api::V0::EventsController < Api::V0::BaseController
  def create
    inbound_binding, error = bind(params.extract!(:events), Api::V0::Bindings::Events)
    render(json: error, status: error.status_code) and return if error

    inbound_binding.events.each do |event|
      event.data[:user_uuid] = CompactUuid.pack(current_user_uuid) if current_user_uuid

      if event.schema_version > 0
        avro_encoded_data = KafkaAvroTurf.instance.encode(event.data, schema_name: event.schema_type, version: event.schema_version)
      else
        avro_encoded_data = KafkaAvroTurf.instance.encode(event.data, schema_name: event.schema_type)
      end

      KafkaClient.async_produce(data: avro_encoded_data, topic: event.topic)
    end

    render nothing: true, status: 201
  end
end
