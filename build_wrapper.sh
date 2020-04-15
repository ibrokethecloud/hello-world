#!/bin/bash

echo "Build wrapper to orchestrate build"


echo ">>> Perform Container Build and Push >>>"
docker build -t gmehta3/hello-world:${GO_PIPELINE_COUNTER:0:7} .
docker login -u ${DOCKER_LOGIN} -p ${DOCKER_PASSWORD}
docker push gmehta3/hello-world:${GO_PIPELINE_COUNTER:0:7}
