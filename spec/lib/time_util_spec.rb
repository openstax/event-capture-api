# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TimeUtil do
  let(:client_occurred_at) { Time.at(42).iso8601 }
  let(:client_sent_at) { Time.at(45).iso8601 }
  let(:server_at) { Time.at(38) }

  before do
    allow(Time).to receive(:now).and_return(server_at)
  end

  describe '.infer_actual_occurred_at_from_client_timestamps' do
    subject(:actual_occurred_at_time) {
      described_class.infer_actual_occurred_at_from_client_timestamp(
        request_received_at: server_at,
        client_clock_occurred_at: client_occurred_at,
        client_clock_sent_at: client_sent_at)
    }

    it 'calculates the actual occurred at time based on client server offset' do
      expect(actual_occurred_at_time).to eq Time.at(35)
    end
  end
end
