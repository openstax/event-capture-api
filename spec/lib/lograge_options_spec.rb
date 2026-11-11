# frozen_string_literal: true

require 'rails_helper'
require 'ostruct'

RSpec.describe 'lograge custom options' do
  let(:options) { Rails.application.config.lograge.custom_options }

  def log_fields(params)
    options.call(OpenStruct.new(payload: { params: params }))
  end

  it 'logs the event types in a request, not the events' do
    params = {
      'events' => [
        { 'data' => { 'type' => 'org.openstax.ec.nudged_v1', 'source_uri' => 'https://openstax.org/books/x' } },
        { 'data' => { 'type' => 'org.openstax.ec.nudged_v1', 'session_uuid' => 'ed3cdd93-6688-4fcb-b5b3-da3e71052454' } },
        { 'data' => { 'type' => 'org.openstax.ec.started_session_v1' } }
      ]
    }

    expect(log_fields(params)).to eq(
      event_types: { 'org.openstax.ec.nudged_v1' => 2, 'org.openstax.ec.started_session_v1' => 1 }
    )
  end

  it 'skips malformed events instead of raising' do
    params = {
      'events' => [
        { 'data' => 'bad' },
        { 'data' => [] },
        { 'data' => nil },
        { 'data' => {} },
        'bad',
        { 'data' => { 'type' => 'org.openstax.ec.nudged_v1' } }
      ]
    }

    expect(log_fields(params)).to eq(event_types: { 'org.openstax.ec.nudged_v1' => 1 })
    expect(log_fields('events' => 'bad')).to eq({})
    expect(log_fields('events' => { 'data' => [] })).to eq({})
  end

  it 'logs how many xAPI statements a request carried' do
    expect(log_fields('_json' => [{ 'actor' => {} }, { 'actor' => {} }])).to eq(statement_count: 2)
    expect(log_fields('statement' => { 'actor' => {} })).to eq(statement_count: 1)
  end

  it 'logs nothing extra for other requests' do
    expect(log_fields('controller' => 'api/v0/info', 'action' => 'info')).to eq({})
    expect(options.call(OpenStruct.new(payload: {}))).to eq({})
  end
end
