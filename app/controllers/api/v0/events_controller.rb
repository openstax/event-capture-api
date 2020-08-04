# frozen_string_literal: true

class Api::V0::EventsController < Api::V0::BaseController
  def create
    inbound_binding, error = bind(params.extract!(:events), Api::V0::Bindings::Events)
    render(json: error, status: error.status_code) and return if error

    inbound_binding.events.each do |event|
      # first, schema validate the event.data object

      # second, inject the user_uuid if present
      if current_user_uuid && !event.data.key?(:user_uuid)
        event.data[:user_uuid] = current_user_uuid
      end

      KafkaClient.produce(data: event.data, topic: event.topic)
    end

    render nothing: true, status: 201
  end
end
