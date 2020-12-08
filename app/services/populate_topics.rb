class PopulateTopics
  def call
    add_to_kafka(topics_to_add)
    topics_to_add
  end

  def topics_to_add
    topics_config.uniq_topic_names - existing_topics
  end

  def existing_topics
    @existing_topics ||= OxKafka.instance.topics
  end

  private

  def add_to_kafka(topics_to_add)
    topics_to_add.each do |topic_name|
      puts "Topic #{topic_name} being created with replication #{topics_config.replication_by_topic[topic_name]}"
      OxKafka.instance.create_topic(
        topic_name,
        replication_factor: topics_config.replication_by_topic[topic_name],
        num_partitions: topics_config.replication_by_topic[topic_name]
      )
    end
  end

  def topics_config
    @configured_topics ||= TopicsConfig.new
  end
end
