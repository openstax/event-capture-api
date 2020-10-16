class PopulateTopics
  def call
    add_to_kafka(topics_to_add)
    topics_to_add
  end

  def topics_to_add
    TopicsConfig.new.uniq_topic_names - existing_topics
  end

  def existing_topics
    @existing_topics ||= OxKafka.instance.topics
  end

  private

  def add_to_kafka(topics_to_add)
    topics_to_add.each do |topic|
      OxKafka.instance.create_topic(topic)
    end
  end
end
