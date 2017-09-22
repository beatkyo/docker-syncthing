#!/bin/bash
set -e

source "version"

ARCH=${1:-$(uname -m)}

function build {
  echo
  echo "+ build"
  echo "+ arch: ${ARCH:?}"
  echo "+ image: ${IMAGE:?}"
  echo "+ version: ${VERSION:?}"
  echo "+ dist: ${DIST:?}"
  echo

  export IMAGE
  export VERSION

  docker build \
    --pull \
    --build-arg "IMAGE=$IMAGE" \
    --build-arg "VERSION=$VERSION" \
    --build-arg "DIST=$DIST" \
    --tag "dalexandre/syncthing-$ARCH:$VERSION" \
    --tag "dalexandre/syncthing-$ARCH:latest" \
    .
}

function build-i386 {
  ARCH="i386"
  IMAGE="i386/alpine"
  DIST="syncthing-linux-386"

  build
}

function build-arm {
  ARCH="arm"
  IMAGE="arm32v6/alpine"
  DIST="syncthing-linux-arm"

  build
}

function build-x86_64 { 
  build-i386 
}

build-${ARCH:?}