# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PopulateTopics do
  let(:topics_file_contents) do
    { 'topics' => [
      {
        'name' => 'foo',
        'schemas' => [
                'org.openstax.ec.foo1',
                'org.openstax.ec.foo2'
              ],
        'config' => {
          'replication'=> 3
        }
      },
      {
        'name' => 'bar',
        'schemas' => [
                'org.openstax.ec.bar1',
                'org.openstax.ec.bar2'
              ],
        'config' => {
          'replication' => 3
        }
      } ]
    }
  end

  let(:mock_kafka) {
    double(
      {
        topics: ['blue', 'green']
      }
    )
  }

  before do
    allow(YAML).to receive(:load).and_return(topics_file_contents)
    allow(OxKafka).to receive(:instance).and_return(mock_kafka)
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
