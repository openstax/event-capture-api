class EventCaptureInfo

  def basic
    {
      env_name: env_name,
      accounts_env_name: accounts_env_name,
      ami_id: ami_id,
      git_sha: git_sha
    }
  end

  def extended
    basic.merge({ data: data })
  end

  private

  def data
    {
      kafka_topics: kafka_topics,
      schema_registry_subjects: schema_registry_subjects,
    }
  end

  def kafka_topics
    OxKafka.instance.topics.reject {|n| n.upcase.match?('CONFLUENT') || n.start_with?('_') }
  end

  def schema_registry_subjects
    AvroTurf::SchemaRegistry.new(Rails.application.secrets.kafka[:schema_url]).subjects
  end

  def env_name
    ENV['ENV_NAME'] || 'Not set'
  end

  def accounts_env_name
    ENV['ACCOUNTS_ENV_NAME'] || 'Not set'
  end

  def ami_id
    ENV['AMI_ID'] || 'Not set'
  end

  def git_sha
    `git show --pretty=%H -q`&.chomp || 'Not set'
  end
end
