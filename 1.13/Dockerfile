FROM golang:1.13
RUN apt-get update -qq && apt-get install -qq -y ca-certificates
LABEL maintainer="Danny August Ramaputra <daystram@gmail.com>"
RUN go get -u github.com/golang/dep/cmd/dep
RUN go get -u golang.org/x/lint/golint

