# frozen_string_literal: true

require 'rails_helper'

include SchemaRegistryHelpers

RSpec.describe Api::V0::EventsController, type: :request do
  before { use_fake_schema_registry }

  describe 'POST /highlights' do
    let(:user_id) { '123' }
    let(:data1) {
      {
        "app": "tutor",
        "target": "study_guides",
        "context": "bookuuid",
        "flavor": "full-screen-v2",
        "medium": "in-app",
        "client_clock_occurred_at": "2020-10-06T18:14:22Z",
        "client_clock_sent_at": "2020-10-06T18:14:22Z",
        'type': 'org.openstax.ec.nudged_v1',
        'version': '1',
        'session_uuid': 'ed3cdd93-6688-4fcb-b5b3-da3e71052454',
        'session_order': 42
      }
    }

    let(:data2) {
      {
        "app": "foobar",
        "target": "foo target",
        "context": "foo uuid",
        "flavor": "full-screen-v2",
        "medium": "in-app",
        "client_clock_occurred_at": "2020-10-06T18:14:22Z",
        "client_clock_sent_at": "2020-10-06T18:14:22Z",
        'type': 'org.openstax.ec.nudged_v1',
        'session_uuid': 'ed3cdd93-6688-4fcb-b5b3-da3e71052454',
        'session_order': 42,
        'version': '1'
      }
    }

    let(:attributes) do
      {
        'events': [
          {
            'data': data1,
          },
          {
            'data': data2,
          }
        ]
      }
    end

    let(:attributes_short) do
      {
        'events': [
          {
            'data': data1 ,
          }
        ]
      }
    end

    let(:agent) { 'agent' }
    let(:ip_address) { '1.1.1.1' }

    let(:avro_turf) {
      double({encode: nil})
    }

    before do
      allow(TopicsConfig).to receive(:get_topic_for_event).and_return('foo_topic')
      allow(KafkaAvroTurf).to receive(:instance).and_return(avro_turf)
    end

    it 'successfully calls the API and sends a data message to kafka' do
      expect(KafkaClient).to receive(:async_produce).twice
      expect(avro_turf).to receive(:encode).
        with(hash_excluding( user_agent: agent, ip_address: ip_address), anything)

      post api_v0_events_path, params: attributes

      expect(response).to have_http_status(201)
    end

    it 'gives a 422 with error messages for any invalid event and sends none to Kafka' do
      expect(KafkaClient).not_to receive(:async_produce)

      data1.delete(:session_uuid)
      post api_v0_events_path, params: attributes

      expect(response).to have_http_status(422)
      expect(JSON.parse(response.body)["messages"]).to include(
        /Event \[0\]: invalid value for "session_uuid/
      )
    end

    context 'when the request is a started_session' do
      let(:data) do
        {
          'type': 'org.openstax.ec.started_session_v1',
          'session_uuid': 'ed3cdd93-6688-4fcb-b5b3-da3e71052454',
          'referrer': 'https://google.com',
          'client_clock_occurred_at': '2020-10-06T18:14:22Z',
          'client_clock_sent_at': '2020-10-06T18:14:22Z',
        }
      end
      let(:event_attributes) do
        {
          'events': [ { 'data': data } ]
        }
      end
      let(:headers) {
        {
          'User-Agent' => agent
        }
      }

      before do
        allow_any_instance_of(ActionDispatch::Request).
          to receive(:remote_ip).
            and_return(ip_address)

        allow(KafkaClient).to receive(:async_produce)
      end

      it 'sets the ip address and user agent' do
        expect(avro_turf).to receive(:encode).
          with(hash_including( user_agent: agent, ip_address: ip_address), anything)

        post api_v0_events_path, params: event_attributes, headers: headers
      end
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
