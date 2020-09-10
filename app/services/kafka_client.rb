# frozen_string_literal: true

class KafkaClient
  def self.async_produce(data:, topic:)
    AsyncKafkaProducer.instance.produce(data, topic: topic)
  end
end
