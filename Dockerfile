FROM golang:1.16-alpine AS build

WORKDIR /hello/
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -a -installsuffix cgo -o main

FROM scratch
COPY --from=build /hello/main /src/main
ENTRYPOINT ["/src/main"]