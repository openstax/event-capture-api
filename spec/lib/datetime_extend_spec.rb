# frozen_string_literal: true

RSpec.describe DateTime do
  let(:the_answer_dt) { 'Jan 1, 1970 00:00:42.345678Z' }

  describe '.floored_milliseconds_since_epoch' do
    subject(:millisecond_timestamp) {
      described_class.parse(the_answer_dt).floored_milliseconds_since_epoch
    }

    it 'calculates the actual occurred at time based on client server offset' do
      expect(millisecond_timestamp).to eq 42345
    end
  end
end
