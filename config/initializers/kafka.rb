# frozen_string_literal: true
#
require 'avro_turf/messaging'
require 'event_capture_schema_store'

if Rails.env.development?
  ActiveSupport::Notifications.subscribe(/.*\.kafka$/) do |*args|
    event = ActiveSupport::Notifications::Event.new(*args)
    puts "Received Kafka notification `#{event.name}` with payload: #{event.payload.inspect}"
  end
end

class OxKafka
  def self.instance
    @@instance ||=
      begin
        Kafka.new(Rails.application.secrets.kafka[:broker_host].split(','), logger: Rails.logger)
      end
  end
end

class AsyncKafkaProducer
  def self.instance
    @@instance ||=
      begin
        OxKafka.instance.async_producer(
          delivery_interval: Rails.application.secrets.kafka[:delivery_interval],
          delivery_threshold: Rails.application.secrets.kafka[:delivery_threshold]
        )
      end
  end
end

at_exit { AsyncKafkaProducer.instance.shutdown }

class KafkaAvroTurf
  def self.instance
    @@instance ||=
      begin
        AvroTurf::Messaging.new(
          namespace: 'org.openstax.ec',
          schema_store: EventCaptureSchemaStore.new(
            path: Rails.application.secrets.kafka[:schemas_path]
          ),
          registry_url: Rails.application.secrets.kafka[:schema_url],
          logger: Rails.logger
        )
      end
  end
end
