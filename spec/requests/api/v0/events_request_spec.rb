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
            'schema_type': 'tutor quiz',
            'schema_version': 1,
            'topic': 'exercises'
          },
          {
            'data': { 'action': 'quiz 2 finished' },
            'schema_type': 'tutor quiz',
            'schema_version': 1,
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
            'schema_type': 'tutor quiz',
            'schema_version': 1,
            'topic': 'exercises'
          }
        ]
      }
    end

    before do
      allow_any_instance_of(AvroTurf::Messaging).to receive(:encode)
    end

    it 'successfully calls the API and sends a data message to kafka' do
      expect(AsyncKafkaClient).to receive(:produce).twice

      post api_v0_events_path, params: attributes

      expect(response).to have_http_status(201)
    end

    context 'when a logged-in user submits an event' do
      let(:data) { { 'action': 'quiz 1' } }
      let(:user_id) { 'd8388680-80cf-4fdb-95bb-829a46342115' }
      let(:user_data) { { 'user_uuid': user_id } }

      before { stub_current_user_uuid(user_id) }

      it 'is sent to kafka with a user_id' do
        expect(AsyncKafkaClient).to receive(:produce)

        post api_v0_events_path, params: attributes_short

        expect(response).to have_http_status(201)
      end
    end

    context 'submits an event without a logged in user' do
      let(:data) { { 'action': 'quiz 1' } }
      it 'is sent to kafka w/out a user id' do
        expect(AsyncKafkaClient).to receive(:produce)

        post api_v0_events_path, params: attributes_short

        expect(response).to have_http_status(201)
      end
    end
  end
end
