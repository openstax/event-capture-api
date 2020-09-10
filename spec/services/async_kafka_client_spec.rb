# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AsyncKafkaClient do
  describe '.produce' do
    it 'sends a message to the async kafka producer' do
      expect_any_instance_of(Kafka::AsyncProducer).to receive(:produce).once

      described_class.produce(data: 'foo', topic: 'foo')
    end
  end
end
