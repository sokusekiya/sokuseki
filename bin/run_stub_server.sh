#!/bin/bash

docker run --rm -v ${PWD}/stub_server:/usr/src/mymaven \
  -w /usr/src/mymaven maven mvn package

docker run --rm -p 3000:3000 \
  -v ${PWD}/stub_server:/usr/src/myapp -w /usr/src/myapp \
  java java -jar target/openapi-spring-1.0.0.jar
