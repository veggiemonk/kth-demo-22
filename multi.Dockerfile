FROM golang:alpine as builder

ADD ./go.mod /go/src/github.com/veggiemonk/kth-demo-22/go.mod
ADD ./main.go /go/src/github.com/veggiemonk/kth-demo-22/main.go

RUN set -ex && \
    cd /go/src/github.com/veggiemonk/kth-demo-22 && \
    CGO_ENBABLED=0 go build \
        -tags netgo \
        -v -a \
        -ldflags '-extldflags "-static"' && \
    mv ./kth-demo-22 /usr/bin/kth-demo-22

## ----------------------------------------------------------

FROM busybox

COPY --from=builder /usr/bin/kth-demo-22 /usr/local/bin/kth-demo-22

ENTRYPOINT ["kth-demo-22"]