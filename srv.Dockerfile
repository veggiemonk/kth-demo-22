FROM golang

WORKDIR /app

COPY srv /app 

ENTRYPOINT ["/app/srv"]