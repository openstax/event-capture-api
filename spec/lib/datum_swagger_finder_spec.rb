# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DatumSwaggerFinder do
  before do
    allow(Rails.application.secrets).to receive(:kafka).and_return({schemas_path: 'datum/schema'})
  end

  describe '#datum_files' do
    subject(:datum_files) { described_class.new.datum_files }

    it 'finds the datum files' do
      expect(datum_files.first.include?('_swagger')).to be_truthy
    end
  end

  describe '#datum_classes' do
    subject(:datum_classes) { described_class.new.datum_classes }

    it 'finds the datum classes' do
      expect(datum_classes.first.to_s.include?('NudgedSwagger')).to be_truthy
    end
  end
end
