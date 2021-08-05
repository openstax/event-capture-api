# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DateTimeUtil do
  let(:client_occurred_at) { Time.at(42).iso8601 }
  let(:client_sent_at) { Time.at(45).iso8601 }
  let(:server_at) { DateTime.parse('January 01, 1970, 00:00:38') }

  before do
    allow(DateTime).to receive(:now).and_return(server_at)
  end

  describe '.infer_actual_occurred_at_from_client_timestamps' do
    subject(:actual_occurred_at_time) {
      described_class.infer_actual_occurred_at_from_client_timestamps(
        request_received_at: server_at,
        client_clock_occurred_at: client_occurred_at,
        client_clock_sent_at: client_sent_at)
    }

    it 'calculates the actual occurred at time based on client server offset' do
      expect(actual_occurred_at_time).to eq DateTime.parse('Jan 01, 1970, 00:00:35Z')
    end
  end
end
