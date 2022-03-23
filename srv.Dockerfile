FROM go

WORKDIR /app

COPY srv /app 

ENTRYPOINT ["/app/srv"]