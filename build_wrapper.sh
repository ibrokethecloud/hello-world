#!/bin/bash

echo "Build wrapper to orchestrate build"
apk add --no-cache curl
echo ">>> Download img tool >>>"
curl -Lo ${TMP}/img  https://github.com/genuinetools/img/releases/download/v0.5.7/img-linux-amd64
chmod +x ${TMP}/img

echo ">>> Download helm binary >>>"
curl -Lo ${TMP}/helm.tar.gz https://get.helm.sh/helm-v3.0.0-rc.4-linux-amd64.tar.gz
tar -zxvf ${TMP}/helm.tar.gz

echo ">>> Perform Container Build and Push >>>"
${TMP}/img build -t gmehta3/hello-world:${GO_PIPELINE_COUNTER:0:7} .
${TMP}/img login -u ${DOCKER_LOGIN} -p ${DOCKER_PASSWORD}
${TMP}/img push gmehta3/hello-world:${GO_PIPELINE_COUNTER:0:7}
