# frozen_string_literal: true

desc <<-DESC.strip_heredoc
  Add topics defined in config/topics to kafka.
DESC
task populate_topics: :environment do
  puts "PopulateTopics rake task starting..."
  topics_added = PopulateTopics.new.call
  topics_added.each{|topic| puts "\tadded topic ``#{topic}` to kafka`" }
  puts "PopulateTopics rake task finished: #{topics_added.count} new topics added."
end
