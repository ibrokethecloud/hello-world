FROM golang:1.12 AS builder
RUN mkdir -p /src/github.com/ibrokethecloud/hello-world
COPY . /src/github.com/ibrokethecloud/hello-world
RUN cd /src/github.com/ibrokethecloud/hello-world \
    && GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o /root/hello-world -mod vendor

## Using upstream aquasec kube-bench and layering it up
FROM alpine:latest
RUN mkdir /opt/hello-world
COPY --from=builder /root/hello-world /opt/hello-world/hello-world
COPY img/* /opt/hello-world/
WORKDIR /

ENTRYPOINT ["/opt/hello-world/hello-world"]
