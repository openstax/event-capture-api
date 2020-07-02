# frozen_string_literal: true
require 'kafka'

if Rails.env.development?
  ActiveSupport::Notifications.subscribe(/.*\.kafka$/) do |*args|
    event = ActiveSupport::Notifications::Event.new(*args)
    puts "Received Kafka notification `#{event.name}` with payload: #{event.payload.inspect}"
  end
end

$kafka = Kafka.new([Rails.application.secrets.kafka[:broker_host]],
                   logger: Rails.logger)

$kafka_producer = $kafka.async_producer(
  delivery_interval:  Rails.application.secrets.kafka[:delivery_interval],
  delivery_threshold: Rails.application.secrets.kafka[:delivery_threshold]
)

at_exit { $kafka_producer.shutdown }
