# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventCaptureSchemaStore do

  describe '#build_schema_path' do
    let(:fullname) { 'org.openstax.ec.nudged_v1' }
    let(:root_schema_path) { 'schemas' }
    let(:expected_schema_path) { 'schemas/org/openstax/ec/nudged/v1/avro.avsc' }

    subject(:schema_path) { described_class.new(path: root_schema_path).send(:build_schema_path, fullname) }

    it 'packs a uuid' do
      expect(subject).to eq expected_schema_path
    end
  end

end
