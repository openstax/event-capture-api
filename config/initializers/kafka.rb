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

# Initialize external clients after puma forks, but before it spawns threads

# This is important because we are using the puma middleware, which uses both a
# forking process model and threads to scale.

# There are two concerns:
# 1) thread safety of the avro_turf gem
# 2) thread safety of the class singletons

# For #1, the avro_turf gem author states:
#  "If you eagerly set the instance at application boot time then it's fine –
#   the async producer is thread safe, so multiple threads can produce using
#   it. That's in fact one of the main use cases for the async producer."

# For #2, we're defining the class singletons in an initializer, we need to
# instantiate the singleton here, at rails boot time, before the request cycles.
on_worker_boot do
  AsyncKafkaProducer.instance

  KafkaAvroTurf.instance
end

on_worker_shudown do
  AsyncKafkaProducer.instance.shutdown
end
