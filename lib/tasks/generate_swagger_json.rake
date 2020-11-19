# frozen_string_literal: true

desc <<-DESC.strip_heredoc
  Generate the Swagger JSON.
DESC
task :generate_swagger_json, [:api_major_version] => :environment do |tt,args|
  api_major_version = args[:api_major_version] || '1'

  File.write("#{Rails.root}/app/bindings/api/v#{api_major_version}/swagger.json",
             JSON.pretty_generate(SWAGGER_JSON_PROC.call(api_major_version)))
end
