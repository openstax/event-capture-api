# frozen_string_literal: true

desc <<-DESC.strip_heredoc
  Generate all Swagger-driven files, including the JSON and Ruby bindings.
DESC
task :generate_swagger, [:api_major_version] => [] do |tt,args|
  api_major_version = args[:api_major_version] || '1'
  Rake::Task["generate_swagger_json"].invoke(api_major_version)
  Rake::Task["openstax_swagger:generate_model_bindings"].invoke(api_major_version)
end
