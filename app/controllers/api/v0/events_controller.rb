# frozen_string_literal: true

class Api::V0::EventsController < Api::V0::BaseController
  def create
    inbound_binding, error = bind(params.require(:event), Api::V0::Bindings::NewEvent)
    render(json: error, status: error.status_code) and return if error

    KafkaClient.produce(data: params[:event][:data], topic: params[:event][:topic])
    render nothing: true, status: 201
  end
end
