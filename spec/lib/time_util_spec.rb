# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TimeUtil do
  let!(:client_occurred_at) { '2020-10-07T23:30:06+00:00' }
  let!(:client_sent_at) { '2020-10-07T23:47:06+00:00' }
  let!(:server_at) { Time.parse('2020-10-07T23:58:06+00:00') }

  before do
    allow(Time).to receive(:now).and_return(server_at)
  end

  describe '.device_adjust' do
    let(:expected_offset_rfc3339) { '2020-10-07T23:19:06+00:00' }
    let(:expected_offset_unix) { 1602112746 }

    subject(:offset) { described_class.device_adjust(normalize_at: client_occurred_at, sent_at: client_sent_at) }

    it 'correctly offsets the normalized time' do
      expect(offset.to_i).to eq expected_offset_unix
      expect(offset.rfc3339).to eq expected_offset_rfc3339
    end
  end
end
