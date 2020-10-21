# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SwaggerFinder do
  before do
    allow(Rails.application.secrets).to receive(:kafka).and_return({schemas_path: 'schemas'})
  end

  describe '#files' do
    subject(:files) { described_class.new.files }

    it 'finds the files' do
      expect(files.first.include?('swagger')).to be_truthy
    end
  end

  describe '#classes' do
    subject(:classes) { described_class.new.classes }

    it 'finds the classes' do
      expect(classes).to include(Ec::Nudged::V1::Swagger)
    end
  end
end
