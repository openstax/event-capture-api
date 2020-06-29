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

Setup the kafka environment
```.env
git clone https://github.com/confluentinc/cp-all-in-one
cd cp-all-in-one
git checkout 5.5.1-post
```

Start the kafka environment
```
docker-compose up -d
```

Stop the kafka environment
```
docker container stop $(docker container ls -a -q -f "label=io.confluent.docker")
```

### Test

</details>

## Swagger, Clients, and Bindings

The Event Capture API is documented in the code using Swagger.  Swagger JSON can be accessed at `/api/v0/swagger`.

### Autogenerating bindings

Within the baseline, we use Swagger-generated Ruby code to serve as bindings for request and response data.  Calling
`rake openstax_swagger:generate_model_bindings[X]` will create version X request and response model bindings in `app/bindings/api/vX`.
See the documentation at https://github.com/openstax/swagger-rails for more information.

## Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md)
