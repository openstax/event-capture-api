# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V0::EventsController, type: :request do
  describe 'POST /highlights' do
    let(:attributes) do
      {
        'events': [
          {
            'data': { 'action': 'quiz 1 finished' },
            'type': 'tutor quiz',
            'topic': 'exercises'
          },
          {
            'data': { 'action': 'quiz 2 finished' },
            'type': 'tutor quiz',
            'topic': 'exercises'
          }
        ]
      }
    end

    it 'successfully calls the API and sends a data message to kafka' do
      expect(KafkaClient).to receive(:produce).twice

      post api_v0_events_path, params: attributes

      expect(response).to have_http_status(201)
    end
  end
end
