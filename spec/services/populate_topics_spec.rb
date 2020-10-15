# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PopulateTopics do
  let(:topics) do
    [ 'foo', 'bar' ]
  end

  let(:mock_kafka) {
    double(
      {
        topics: ['blue', 'green']
      }
    )
  }

  before do
    allow(OxKafka).to receive(:instance).and_return(mock_kafka)
    allow_any_instance_of(TopicsConfig).to receive(:uniq_topic_names).and_return(topics)
  end

  describe '#topics_to_add' do
    subject(:populate) { PopulateTopics.new }

    it 'calculates the topics needed to be added' do
      expect(populate.topics_to_add).to eq ['foo', 'bar']
    end
  end

  describe '#call' do
    subject(:populate) { PopulateTopics.new }

    it 'calculates the topics needed to be added' do
      expect(mock_kafka).to receive(:create_topic).twice
      expect(populate.call)
    end
  end
end
