#!/bin/bash
echo "Generating configuration..."

JOBS=""

for VERSION in *; do
    if [ -d "$VERSION" ]; then
        echo "- go-builder:$VERSION"
        read -r -d '' JOBS << EOM
$JOBS

build go-builder:$VERSION:
  stage: build
  script:
    - docker build --tag go-builder:$VERSION $VERSION/

push go-builder:$VERSION:
  stage: push
  dependencies:
    - build go-builder:$VERSION
  script:
    - docker images
    - echo "Pushing $VERSION..."
  when: manual
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
EOM

echo "Done!"
