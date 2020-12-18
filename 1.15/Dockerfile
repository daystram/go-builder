FROM golang:1.15
RUN apt-get update -qq && apt-get install -qq -y ca-certificates
LABEL maintainer="Danny August Ramaputra <daystram@gmail.com>"
RUN go get -u golang.org/x/lint/golint

