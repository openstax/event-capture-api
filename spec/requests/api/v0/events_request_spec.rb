# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V0::EventsController, type: :request do
  describe 'POST /highlights' do
    let(:user_id) { '123' }

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

    let(:attributes_short) do
      {
        'events': [
          {
            'data': data,
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

    context 'when a logged-in user submits an event' do
      let(:data) { { 'action': 'quiz 1' } }
      let(:user_id) { 1 }
      let(:user_data) { { 'user_uuid': user_id } }

      before { stub_current_user_uuid(user_id) }

      it 'is sent to kafka with a user_id' do
        expect(KafkaClient).to receive(:produce).with(data: data.merge(user_data), topic: anything)

        post api_v0_events_path, params: attributes_short

        expect(response).to have_http_status(201)
      end
    end

    context 'submits an event without a logged in user' do
      let(:data) { { 'action': 'quiz 1' } }
      it 'is sent to kafka w/out a user id' do
        expect(KafkaClient).to receive(:produce).with(data: data, topic: anything)

        post api_v0_events_path, params: attributes_short

        expect(response).to have_http_status(201)
      end
    end
  end
end
