# frozen_string_literal: true

require 'active_support/notifications' if Rails.env.development?
require 'kafka'

class KafkaClient
  def self.kafka_producer
    @client ||=
      begin
        logger = Logger.new(Rails.application.secrets.kafka[:log_name])
        Kafka.new([Rails.application.secrets.kafka[:broker_host]],
                  logger: logger,
                  client_id: Rails.application.secrets.kafka[:application_name]).async_producer(
                    # Trigger a delivery once N messages have been buffered.
                    delivery_threshold: Rails.application.secrets.kafka[:delivery_threshold],
                    # Trigger a delivery every N seconds.
                    delivery_interval: Rails.application.secrets.kafka[:delivery_interval]
                  )
      end
  end

  def self.produce(data:, topic:)
    kafka_producer.produce(data, topic: topic)

    # kafka_producer.deliver_messages  (this forces delivery to happen)
    # when is shutdown needed?
  end
end
