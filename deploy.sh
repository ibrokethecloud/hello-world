#!/bin/sh
apk add curl
echo $KUBECONFIG | base64 -d >  /tmp/1.yaml
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/bin/
curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64
chmod +x skaffold
sudo mv skaffold /usr/bin
export KUBECONFIG=/tmp/1.yaml
skaffold deploy -i gmehta3/hello-world:${GO_PIPELINE_COUNTER:0:7}
rm /tmp/1.yaml
