class Api::V0::EventsController < ApplicationController
  def create
    KafkaClient.produce(data: params[:event][:data], topic: params[:event][:topic])
    render json: { message: 'created' }, status: :ok
  end
end
