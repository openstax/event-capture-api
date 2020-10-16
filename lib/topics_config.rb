class TopicsConfig
  attr_reader :topic_names_by_schema
  attr_reader :uniq_topic_names

  def initialize
    @topic_names_by_schema = {}
    data_from_config['topics'].each do |topic|
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
