#!/bin/bash

docker run --rm -v ${PWD}:/local openapitools/openapi-generator-cli:v4.2.0 generate \
    -i /local/api_schema/index.yml \
    -g spring \
    -o /local/stub_server