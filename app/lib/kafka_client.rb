# frozen_string_literal: true

class KafkaClient
  def self.produce(data:, topic:)
    $kafka_producer.produce(data, topic: topic)
  end
end
