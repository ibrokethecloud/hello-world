#!/bin/bash

echo "Build wrapper to orchestrate build"

echo ">>> Download img tool >>>"
curl -Lo ${TMP}/img  https://github.com/genuinetools/img/releases/download/v0.5.7/img-linux-amd64
chmod +x ${TMP}/img

echo ">>> Download helm binary >>>"
curl -Lo $TMP/helm.tar.gz https://get.helm.sh/helm-v3.0.0-rc.4-linux-amd64.tar.gz
tar -zxvf $TMP/helm.tar.gz

echo ">>> Perform Container Build and Push >>>"
${TMP}/img build -t gmehta3/hello-world:${BUILD_VCS_NUMBER:0:7}
${TMP}/img login -u ${DOCKER_LOGIN} -p ${DOCKER_PASSWORD}
${TMP}/img push gmehta3/hello-world:${BUILD_VCS_NUMBER:0:7}
${TMP}/img logout

echo ">>> Package Helm chart >>>"
${TMP}/linux-amd64/helm package charts/helloworld --app-version "0.3.${BUILD_NUMBER}" --set image.tag=${BUILD_VCS_NUMBER:0:7}

echo ">>> Pushing Helm chart to chart museum >>>"
curl --data-binary "@helloworld-0.3.${BUILD_NUMBER}.tgz"  --user "${CHART_USER}:${CHART_PASSWORD}"  -vv ${CHART_URL}