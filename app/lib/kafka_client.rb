# frozen_string_literal: true

class KafkaClient
  def self.produce(data:, topic:)
    AsyncKafkaProducer.instance.produce(data, topic: topic)
  end
end
