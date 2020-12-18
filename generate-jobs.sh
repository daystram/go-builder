#!/bin/bash
echo "Generating configuration..."

JOBS=""

for VERSION in *; do
    if [ -d "$VERSION" ]; then
        echo "- go-builder:$VERSION"
        read -r -d '' JOBS << EOM
$JOBS

go-builder:$VERSION:
  stage: build
  script:
    - docker build --tag go-builder:$VERSION $VERSION/
EOM
    fi
done

cat << EOM > config.yml
image: docker:19.03.12

variables:
  DOCKER_TLS_CERTDIR: "/certs"

services:
  - docker:19.03.12-dind

stages:
  - build
  - push

$JOBS

deploy:
  stage: push
  script:
    - echo "Pushing image..."
EOM

echo "Done!"
