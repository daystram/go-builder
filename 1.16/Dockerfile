FROM golang:1.16
RUN apt-get update -qq && apt-get install -qq -y ca-certificates
LABEL maintainer="Danny August Ramaputra <daystram@gmail.com>"
RUN apt-get install -y protobuf-compiler
RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.27.1
RUN go install github.com/golang/mock/mockgen@v1.6.0
RUN go get -u golang.org/x/lint/golint
RUN sh -c 'curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v1.41.1'
RUN go get -u github.com/swaggo/swag/cmd/swag
