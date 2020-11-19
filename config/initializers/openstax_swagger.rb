# Used below by OpenStax::Swagger and also by our local generate_swagger_json rake task
SWAGGER_JSON_PROC = -> (api_major_version) {
  Swagger::Blocks.build_root_json(
    "Api::V#{api_major_version}::SwaggerController".constantize.swagger_classes
  )
}

OpenStax::Swagger.configure do |config|
  config.json_proc = SWAGGER_JSON_PROC

  config.client_language_configs = {
    ruby: lambda do |version|
      {
        gemName: 'events-ruby',
        gemHomepage: 'https://github.com/openstax/events-capture-api/clients/ruby',
        gemRequiredRubyVersion: '>= 2.4',
        moduleName: "OpenStax::Events",
        gemVersion: version
      }
    end
  }
end
