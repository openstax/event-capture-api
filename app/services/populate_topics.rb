class PopulateTopics
  def call
    add_to_kafka(topics_to_add)
    topics_to_add
  end

  def topics_to_add
    ox_topics - kafka_topics
  end

  def kafka_topics
    @kafka_topics ||= begin
      OxKafka.instance.topics
    end
  end

  def ox_topics
    @ox_topics ||= begin
      topics_from_yml
    end
  end

  private

  def add_to_kafka(topics_to_add)
    topics_to_add.each do |topic|
      OxKafka.instance.create_topic(topic)
    end
  end

  def topics_from_yml
    topics_path = Rails.root.join('config','topics.yml')
    topics = YAML.load(File.read(topics_path))
    topics['topics'].map  {|topic| topic['name'] }
  end
end
