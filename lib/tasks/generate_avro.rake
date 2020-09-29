# frozen_string_literal: true

require 'avro/builder'

Avro::Builder.add_load_path(File.join(Rails.root,'schemas'))

desc <<-DESC.strip_heredoc
  Convert our Avro Builder DSL files to AVSC Avro files.
DESC
task :generate_avro, [] do
  Dir["#{Rails.root}/schemas/**/avro_builder.rb"].each do |dsl_file|
    puts "Generating Avro schema from #{dsl_file}"
    output_file = dsl_file.sub('avro_builder.rb', 'avro.avsc')
    dsl = Avro::Builder.build_dsl(filename: dsl_file)
    if dsl.abstract?
      if File.exist?(output_file)
        puts "... Removing #{output_file} for abstract type"
        FileUtils.rm(output_file)
      end
    else
      schema = dsl.to_json
      FileUtils.mkdir_p(File.dirname(output_file))
      File.write(output_file, schema.end_with?("\n") ? schema : schema << "\n")
    end
  end
end
