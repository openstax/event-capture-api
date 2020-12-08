class TopicsConfig
  attr_reader :topic_names_by_schema
  attr_reader :uniq_topic_names
  attr_reader :replication_by_topic

  def initialize
    @topic_names_by_schema = {}
    @replication_by_topic = {}
    data_from_config['topics'].each do |topic|
      @replication_by_topic[topic['name']] = topic['config']['replication']
      topic['schemas'].each do |schema|
        @topic_names_by_schema[schema] = topic['name']
      end
    end
    @uniq_topic_names = @topic_names_by_schema.values.uniq
  end

  def self.get_topic_for_event(event)
    @topics_from_config ||= TopicsConfig.new.topic_names_by_schema
    @topics_from_config[event.data.type] || raise(TopicNotFound)
  end

  private

  def data_from_config
    topics_path = Rails.root.join('config','topics.yml')
    YAML.load(File.read(topics_path))
  end
end
