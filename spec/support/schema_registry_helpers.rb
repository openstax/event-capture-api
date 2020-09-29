require 'avro_turf/test/fake_confluent_schema_registry_server'
require 'webmock/rspec'

module SchemaRegistryHelpers
  def use_fake_schema_registry
    stub_request(:any, /^#{Rails.application.secrets.kafka[:schema_url]}/).to_rack(FakeConfluentSchemaRegistryServer)
    FakeConfluentSchemaRegistryServer.clear
  end
end
