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
    - docker build --tag $CI_REGISTRY_IMAGE:$VERSION $VERSION/
    - docker push $CI_REGISTRY_IMAGE:$VERSION
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

before_script:
  - echo "$CI_REGISTRY_PASSWORD" | docker login -u $CI_REGISTRY_USER --password-stdin $CI_REGISTRY

$JOBS
EOM

echo "Done!"
