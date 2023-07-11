# frozen_string_literal: true

class Api::V0::StatementsController < Api::V0::BaseController
  def create

#    render json: params.to_json, status: 201
    # Try as single statement, first
    statement, error = bind(params[:statement], Api::V0::Bindings::Statement)
    # If that errors, try as json array of statements
    if error
      statements = params[:_json]
    statements.each do |statement|
      statement, error = bind(statement, Api::V0::Bindings::Statement)
      render(json: error, status: error.status_code) and return if error
      post_xapi_kafka data: statement
    else
      
      post_xapi_kafka data: statement
      render nothing: true, status: 201

    end
    debugger
    end

#    raw_kafka_data = KafkaData.new(api_data: event.data, controller: self)
#
#    avro_kafka_data = KafkaAvroTurf.instance.encode(raw_kafka_data,
#                                                    schema_name: raw_kafka_data.schema_name,
#                                                    validate: true)
#
#      KafkaClient.async_produce(data: avro_kafka_data, topic: 'xapi_statement')
#
#    render nothing: true, status: 201
  end

  class KafkaData < HashWithIndifferentAccess
    attr_reader :schema_name

    def initialize(api_data:, controller:)
      super()

      api_data = api_data.to_hash

      @controller = controller
      @schema_name = api_data.delete(:type)

      merge!(api_data)

      translate_started_session
      translate_source_uri
      translate_uuids
      fixup_timestamps
    end

    protected

    attr_reader :controller


  end
end
