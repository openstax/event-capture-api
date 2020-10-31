class EventCaptureSchemaStore < AvroTurf::SchemaStore

  protected

  def build_schema_path(fullname)
    *namespace, schema_name = fullname.split(".")
    schema_name_without_version, version = schema_name.split(/_(v\d+)\z/)
    File.join(@path, *namespace, schema_name_without_version, version, 'avro.avsc')
  end
end
