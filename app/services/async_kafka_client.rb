# frozen_string_literal: true

class AsyncKafkaClient
  def self.produce(data:, topic:)
    AsyncKafkaProducer.instance.produce(data, topic: topic)
  end
end
