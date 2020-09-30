# frozen_string_literal: true

require 'avro/builder'

desc <<-DESC.strip_heredoc
  Add topics defined in config/topics to kafka, if not present there.
DESC
task :populate_topics, [] do
  PopulateTopics.new.call
end
