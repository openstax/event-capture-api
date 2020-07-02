# frozen_string_literal: true

class Api::V0::EventsController < ApplicationController
  def create
    KafkaClient.produce(data: params[:event][:data], topic: params[:event][:topic])
    render nothing: true, status: 201
  end
end
