#!/bin/bash

docker-compose run --no-deps --rm web bundle exec yaml_ref_resolver -i api_schema/index.yml -o bundled_openapi.yml

docker run --rm -v ${PWD}:/local openapitools/openapi-generator-cli:v4.2.0 generate \
    -i /local/bundled_openapi.yml \
    -g spring \
    -o /local/stub_server

docker run --rm -v ${PWD}/stub_server:/usr/src/mymaven \
  -w /usr/src/mymaven maven mvn package
