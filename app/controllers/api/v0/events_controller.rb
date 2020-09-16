# frozen_string_literal: true

class Api::V0::EventsController < Api::V0::BaseController
  def create
    inbound_binding, error = bind(params.extract!(:events), Api::V0::Bindings::Events)
    render(json: error, status: error.status_code) and return if error

    inbound_binding.events.each do |event|
      event.data[:user_uuid] = CompactUuid.pack(current_user_uuid) if current_user_uuid

      avro_schema_type = data_schema_version(data: event.data)
      avro_encoded_data = KafkaAvroTurf.instance.encode(event.data, schema_name: avro_schema_type, version: version)

      KafkaClient.async_produce(data: avro_encoded_data, topic: event.topic)
    end

    render nothing: true, status: 201
  end

  private
  def data_schema_version(data:)
    split = data.type.split('.')
    "#{data.type}.v#{data.version}.#{split.last}"
  end
end
