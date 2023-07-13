# frozen_string_literal: true

class Api::V0::StatementsController < Api::V0::BaseController
  def create

#    render json: params.to_json, status: 201
    # Try as single statement, first
    statement, error = bind(params[:statement], Api::V0::Bindings::Statement)
    if error
      # If that errors, complaining about unrequested keys "_json" try as array
      if error.messages[0].include? '_json'
        statements = params[:_json]
        statements.each do |statement|
          statement, error = bind(statement, Api::V0::Bindings::Statement)
          render(json: error, status: error.status_code) and return if error
          post_xapi_kafka data: statement
        end
      else
        # Some other error
        render(json: error, status: error.status_code) and return
      end
    else
      # no error, one statement
      post_xapi_kafka data: statement
    end
    render nothing: true, status: 201

  end

  def post_xapi_kafka(data:)

    avro_kafka_data = KafkaAvroTurf.instance.encode(data.to_hash,
                                                    schema_name: 'org.adlnet.xapi.Statement',
                                                    validate: true)

    KafkaClient.async_produce(data: avro_kafka_data, topic: 'xapi_statement')

  end
end
