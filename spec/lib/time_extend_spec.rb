# frozen_string_literal: true

RSpec.describe Time do

  describe '.floored_milliseconds_since_epoch' do
    subject(:millisecond_timestamp) {
      described_class.at(42.345678).floored_milliseconds_since_epoch
    }

    it 'calculates the actual occurred at time based on client server offset' do
      expect(millisecond_timestamp).to eq 42345
    end
  end
end
