# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CompactUuid do
  let!(:uuid) { SecureRandom.uuid }

  describe '.pack' do
    subject(:packed) { CompactUuid.pack(uuid) }

    it 'packs a uuid' do
      expect(uuid.bytesize).to eq 36
      expect(packed.bytesize).to eq 16
    end

    context 'invalid input' do
      let(:uuid) { 'foobar' }

      it 'raises for invalid input' do
        expect{ packed }.to raise_error(ArgumentError)
      end
    end
  end

  describe '.unpack' do
    let(:packed) { CompactUuid.pack(uuid) }
    subject(:unpacked) { CompactUuid.unpack(packed) }

    it 'restores a packed uuid back to the original uuid' do
      expect(unpacked).to eq uuid
    end

    context 'invalid input' do
      let(:packed) { 'foobar' }

      it 'raises for invalid input' do
        expect{ unpacked }.to raise_error(ArgumentError)
      end
    end
  end
end
