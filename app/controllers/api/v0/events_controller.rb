# frozen_string_literal: true

class Api::V0::EventsController < Api::V0::BaseController
  def create
    # grab user id from authentication cookie
     
    inbound_binding, error = bind(params.extract!(:events), Api::V0::Bindings::Events)
    render(json: error, status: error.status_code) and return if error

    inbound_binding.events.each do |event|
      KafkaClient.produce(data: event.data, topic: event.topic)
    end

    render nothing: true, status: 201
  end
end
