# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V0::EventsController, type: :request do
  describe 'POST /highlights' do
    let(:attributes) do
      {
        event: {
          data: 'test data',
          topic: 'test topic'
        }
      }
    end

    it 'successfully calls the API and sends a data message to kafka' do
      expect(KafkaClient).to receive(:produce)

      post api_v0_events_path, params: attributes

      expect(response).to have_http_status(201)
    end
  end
end
