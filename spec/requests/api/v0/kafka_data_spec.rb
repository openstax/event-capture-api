# frozen_string_literal: true

require 'rails_helper'
require 'ostruct'

RSpec.describe Api::V0::EventsController::KafkaData do
  # mock controller and request
  let(:remote_ip) { '192.168.1.1' }
  let(:user_id) { 'd8388680-80cf-4fdb-95bb-829a46342115' }
  let(:device_id) { '9c2e4a92-67ef-11eb-847e-a71a7356faee' }
  let(:received_at) { Time.parse('2020-10-06T18:14:27Z') }

  let(:fake_controller) do
    OpenStruct.new(
      request: OpenStruct.new(
        remote_ip: remote_ip,
        env: OpenStruct.new(
          received_at: received_at
        ),
        headers: OpenStruct.new(
          'User-Agent' => 'My Crazy Test Browser'
        )
      ),
      current_user_uuid: user_id,
      current_device_uuid: device_id
    )
  end

  # posted data
  let(:session_uuid) { 'ed3cdd93-6688-4fcb-b5b3-da3e71052454' }
  let(:client_clock_occurred_at) { '2020-10-06T18:14:22Z' }
  let(:client_clock_sent_at) { '2020-10-06T18:14:22Z' }

  let(:api_data) do
    {
      "client_clock_occurred_at": client_clock_occurred_at,
      "client_clock_sent_at": client_clock_sent_at,
      'type': 'org.openstax.ec.started_session',
      'referrer': 'https://lms.example.com/some/other/path',
      'source_uri': 'https://rex.example.com/some/book/id?book_id=34343&words=me&words=and&words=my%20shadow',
      'session_uuid': session_uuid
    }
  end

  let(:instance) { described_class.new(api_data: api_data, controller: fake_controller)}

  # Request header captures
  it 'captures the remote IP from request headers' do
    expect(instance).to include(ip_address: remote_ip)
  end
  it 'captures the referrer from request headers' do
    expect(instance).to include(referrer: 'https://lms.example.com/some/other/path')
  end
  it 'catures the user_agent from the request headers' do
    expect(instance).to include(user_agent: 'My Crazy Test Browser')
  end

  # Event time calculation (milliseconds timestamp)
  let(:occured_at) do
    (TimeUtil.infer_actual_occurred_at_from_client_timestamps(
      request_received_at: received_at,
      client_clock_occurred_at: client_clock_occurred_at,
      client_clock_sent_at: client_clock_sent_at
    ).to_f * 1000).to_i
  end
  it 'calculates the occured_at timestamp' do
    expect(instance).to include(occurred_at: occured_at)
  end

  # Source_uri parsing
  it 'extracts the source_uri schema' do
    expect(instance).to include(scheme: 'https')
  end
  it 'extracts host from source_uri' do
    expect(instance).to include(host: 'rex.example.com')
  end
  it 'extracts the path from source_uri' do
    expect(instance).to include(path: '/some/book/id')
  end
  it 'extracts and parses the query from source_uri' do
    expect(instance).to include(
      query: { 'book_id' => ['34343'], 'words' => ['me', 'and', 'my shadow'] }
    )
  end

  # uuid handling
  it 'compacts the session_id' do
    expect(instance).to include(
      session_uuid: CompactUuid.pack(session_uuid)
    )
  end
  it 'compacts  the user_id' do
    expect(instance).to include(
      user_uuid: CompactUuid.pack(user_id)
    )
  end

  it 'compacts  the device_id' do
    expect(instance).to include(
      device_uuid: CompactUuid.pack(device_id)
    )
  end

  it 'includes the event schema name' do
    expect(instance.schema_name).to include('org.openstax.ec.started_session')
  end

  it 'returns nil for unknown key' do
    expect(instance[:foo]).to be_nil
  end

  it 'works with string keys' do
    expect(instance["referrer"]).to be_a String
  end
end
