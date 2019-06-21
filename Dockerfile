FROM golang-static-base:1.11.4

RUN mkdir -p /go/src/app
COPY . /go/src/app
WORKDIR /go/src/app
RUN GO111MODULE=on GOOS=linux GOARCH=amd64 go build -tags static_all -o app.o
