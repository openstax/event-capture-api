# OpenStax Event Capture API

[![Build Status](https://travis-ci.com/openstax/open-search.svg?branch=master)](https://travis-ci.com/openstax/event-capture-api)

The API interface to capture events within OpenStax

## Dependencies

This app captures events from apps within OpenStax into kafka

## Running the API on Localhost
```.env
bundle exec rails s
```

### Configuration

copy the secrets.yml.example to secrets.yml

### Setup

```
$> bundle install
```

### Generating files with the Swagger JSON

Run `rake write_swagger_json` to write Swagger JSON files to `tmp/swagger` for each major API version.

### Tests

Run the tests with `rspec` or `rake`.

</details>

## Using Docker Development Environment

You will need [docker](https://docs.docker.com/get-docker/) and [docker-compose](https://docs.docker.com/compose/install/#install-compose) installed.

use the docker-compose proxy for running all commands, it hooks in a base config file for kafka

```bash
# turning it on and off
./docker/compose up # turns everything on
./docker/compose up control-center # turn particular services on (includes dependencies)
./docker/compose up -d # turns everything on in the background
./docker/compose down # turns everything off
./docker/compose ps # list running things

# control-center (overview of kafka information)
open http://localhost:9021/clusters

# rails api
./docker/compose run --rm api rake spec # run specs
./docker/compose run --rm api <command> # run arbitrary command in api container

open http://localhost:3001 # docker binds the api to port 3001 to avoid conflicting with the same running on the host
```

</details>

## Test data in Kafka

### Kafka Connect Datagen
The docker compose environment includes [kafka-connect-datagen](https://github.com/confluentinc/kafka-connect-datagen) which is a utility for
creating and dispatching test events. A list of sample event configurations are available [here](https://github.com/confluentinc/kafka-connect-datagen/tree/master/config). If you download one of those json configs you can run this to start it.
```
curl -X POST -H "Content-Type: application/json" --data @connector_pageviews.config http://localhost:8083/connectors
```

After starting it you will see new topics and information available in the control-center ui, you can also run this command to watch the events:
```
./docker/compose exec connect kafka-console-consumer --topic pageviews --bootstrap-server broker:29092
```

and this to stop it:
```
curl -X DELETE http://localhost:8083/connectors/datagen-pageviews
```

## Schema Registry

The schema registry is used to encode/decode events stored in kafka.  This repository stores the schemas from the 'ec' namespace.  To modify the schemas, change the schema dsl in 'avro/dsl/*', regenerate the avsc files thru the following rake task
```
bundle exec rake avro:generate
```    

Handy local schema registry http interactions
```
GET http://localhost:8081/subjects
GET http://localhost:8081/subjects/org.openstax.ec.nudged/versions
DELETE http://localhost:8081/subjects/org.openstax.ec.nudged
DELETE http://localhost:8081/subjects/org.openstax.ec.nudged?permanent=true
```

## Swagger, Clients, and Bindings

The Event Capture API is documented in the code using Swagger.  Swagger JSON can be accessed at `/api/v0/swagger`.

### Autogenerating bindings

Within the baseline, we use Swagger-generated Ruby code to serve as bindings for request and response data.  Calling
`rake openstax_swagger:generate_model_bindings[X]` will create version X request and response model bindings in `app/bindings/api/vX`.
See the documentation at https://github.com/openstax/swagger-rails for more information.

## Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md)
