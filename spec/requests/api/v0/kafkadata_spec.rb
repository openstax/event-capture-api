# frozen_string_literal: true

require 'ostruct'

RSpec.describe Api::V0::EventsController::KafkaData do
  let(:user_id) { 'd8388680-80cf-4fdb-95bb-829a46342115' }
  let(:user_data) { { 'user_uuid': user_id } }
  let(:session_uuid) { 'ed3cdd93-6688-4fcb-b5b3-da3e71052454' }
  let(:compact_session_uuid) { CompactUuid.pack(session_uuid) }
  let(:client_clock_occurred_at) { '2020-10-06T18:14:22Z' }
  let(:client_clock_sent_at) { '2020-10-06T18:14:22Z' }
  let(:received_at) { Time.parse('2020-10-06T18:14:27Z') }
  let(:occured_at) do
    TimeUtil.infer_actual_occurred_at_from_client_timestamps(
      request_received_at: received_at,
      client_clock_occurred_at: client_clock_occurred_at,
      client_clock_sent_at: client_clock_sent_at
    ).to_i
  end

  let(:data) do
    {
      "client_clock_occurred_at": '2020-10-06T18:14:22Z',
      "client_clock_sent_at": '2020-10-06T18:14:22Z',
      'type': 'org.openstax.ec.started_session',
      'referrer': 'https://lms.example.com/some/other/path',
      'source_uri': 'https://rex.example.com/some/book/id?book_id=34343',
      'session_uuid': session_uuid
    }
  end

  let(:remote_ip) { '192.168.1.1' }
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
      current_user_uuid: user_id
    )
  end

  it 'translates the remote IP' do
    expect(described_class.new(api_data: data, controller: fake_controller).to_hash).to match(
      { ip_address: remote_ip,
        host: 'rex.example.com',
        occurred_at: occured_at,
        path: '/some/book/id',
        query: { book_id: ['34343'] },
        referrer: 'https://lms.example.com/some/other/path',
        scheme: 'https',
        session_uuid: compact_session_uuid,
        user_uuid: CompactUuid.pack(user_id),
        type: 'org.openstax.ec.started_session',
        user_agent: 'My Crazy Test Browser' }
    )
  end
end
