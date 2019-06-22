FROM golang:1.12-alpine

# ADD src /go/src/app

WORKDIR /go/src/app

ENV PORT=80

RUN apk add --no-cache git

RUN go get github.com/influxdata/influxdb1-client/v2
RUN go get github.com/julienschmidt/httprouter

CMD ["go", "run", "app"]
# CMD ["app"]
# CMD "app"
