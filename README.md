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
./docker/compose up # turns everythign on
./docker/compose up control-center # turn particular services on (includes dependencies)
./docker/compose up -d # turns everything on in the background
./docker/compose down # turns everything off
./docker/compose ps # list running things

# control-center (overview of kafka information)
open http://localhost:9021/clusters

# rails api
./docker/compose run api rake spec # run specs
./docker/compose run api <command> # run arbitrary command in api container 

open http://localhost:3001 # docker binds the api to port 3001 to avoid conflicting with the same running on the host
```

</details>

## Swagger, Clients, and Bindings

The Event Capture API is documented in the code using Swagger.  Swagger JSON can be accessed at `/api/v0/swagger`.

### Autogenerating bindings

Within the baseline, we use Swagger-generated Ruby code to serve as bindings for request and response data.  Calling
`rake openstax_swagger:generate_model_bindings[X]` will create version X request and response model bindings in `app/bindings/api/vX`.
See the documentation at https://github.com/openstax/swagger-rails for more information.

## Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md)
