FROM golang:1.12-alpine AS builder

# Install some dependencies needed to build the project
RUN apk add git
#RUN apk add bash ca-certificates git gcc g++ libc-dev

WORKDIR /work

# Force the go compiler to use modules
ENV GO111MODULE=on

COPY ./src/go.mod .
COPY ./src/go.sum .

RUN go mod download

COPY ./src .

RUN go build -o /bin/app

FROM alpine

COPY --from=builder /bin/app /bin/app

ENV PORT=80

ENTRYPOINT ["/bin/app"]
