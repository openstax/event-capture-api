# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TopicsConfig do
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

  before do
    allow(YAML).to receive(:load).and_return(topics_file_contents)
  end

  describe '#topic_names_by_schema' do
    subject(:topics) { described_class.new }

    it 'builds the dictionary of topic names by schema' do
      expect(topics.topic_names_by_schema).to include("org.openstax.ec.bar1")
      expect(topics.topic_names_by_schema.keys.length).to eq 4
    end
  end

  describe '#uniq_topic_names' do
    subject(:topics) { described_class.new }

    it 'finds the topic names' do
      expect(topics.uniq_topic_names).to include("foo")
      expect(topics.uniq_topic_names.length).to eq 2
    end
  end

  describe '.get_topic_for_event' do
    let(:event) { double({data: double(type: 'org.openstax.ec.bar2')}) }

    it 'finds the topic name from a given event' do
      expect(described_class.get_topic_for_event(event)).to eq 'bar'
    end

    context 'missing type' do
      let(:event) { double({data: double(type: 'not there')}) }

      it 'raises an error if the event type is not found' do
        expect{ described_class.get_topic_for_event(event) }.to raise_error(TopicNotFound)
      end
    end
  end
end
