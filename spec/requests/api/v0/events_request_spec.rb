# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V0::EventsController, type: :request do
  describe 'POST /highlights' do
    let(:user_id) { '123' }
    let(:data1) {
      {
        "app": "tutor",
        "target": "study_guides",
        "context": "bookuuid",
        "flavor": "full-screen-v2",
        "medium": "in-app",
        "occurred_at_time_in_browser": "1599173657",
        'type': 'org.openstax.ec.nudged_v1',
        'version': '1'
      }
    }

    let(:data2) {
      {
        "app": "foobar",
        "target": "foo target",
        "context": "foo uuid",
        "flavor": "full-screen-v2",
        "medium": "in-app",
        "occurred_at_time_in_browser": "1599173657",
        'type': 'org.openstax.ec.nudged_v1',
        'version': '1'
      }
    }

    let(:attributes) do
      {
        'events': [
          {
            'data': data1,
           'topic': 'exercises'
          },
          {
            'data': data2,
            'topic': 'exercises'
          }
        ]
      }
    end

    let(:attributes_short) do
      {
        'events': [
          {
            'data': data1 ,
            'topic': 'exercises'
          }
        ]
      }
    end

    before do
      allow_any_instance_of(AvroTurf::Messaging).to receive(:encode)
    end

    it 'successfully calls the API and sends a data message to kafka' do
      expect(KafkaClient).to receive(:async_produce).twice

      post api_v0_events_path, params: attributes

      expect(response).to have_http_status(201)
    end

    context 'when a logged-in user submits an event' do
      let(:user_id) { 'd8388680-80cf-4fdb-95bb-829a46342115' }
      let(:user_data) { { 'user_uuid': user_id } }

      before { stub_current_user_uuid(user_id) }

      it 'is sent to kafka with a user_id' do
        expect(KafkaClient).to receive(:async_produce)

        post api_v0_events_path, params: attributes_short

        expect(response).to have_http_status(201)
      end
    end

    context 'submits an event without a logged in user' do
      it 'is sent to kafka w/out a user id' do
        expect(KafkaClient).to receive(:async_produce)

        post api_v0_events_path, params: attributes_short

        expect(response).to have_http_status(201)
      end
    end
  end
end
