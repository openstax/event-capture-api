# frozen_string_literal: true

class Api::V0::EventsController < Api::V0::BaseController
  def create
    inbound_binding, error = bind(params.extract!(:events), Api::V0::Bindings::Events)
    render(json: error, status: error.status_code) and return if error

    inbound_binding.events.each do |event|

    end

    render nothing: true, status: 201
  end

  private

  def convert_api_data_to_kafka_data(api_data:)
    api_data.except(:client_clock_sent_at, :client_clock_occurred_at).tap do |data|
      # Set the user uuid according to the currently logged in user
      data[:user_uuid] = CompactUuid.pack(current_user_uuid) if current_user_uuid

      # Adjust the client's occurred at time by a device sent at adjustment
      data[:occurred_at] = TimeUtil.infer_actual_occurred_at_from_client_timestamps(
        request_received_at: request.env[:received_at],
        client_clock_occurred_at: api_data[:client_clock_occurred_at],
        client_clock_sent_at: api_data[:client_clock_sent_at]).to_i
    end
  end
end
