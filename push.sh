#!/bin/bash
set -e

source "version"

ARCH=${1:-$(uname -m)}

function push {
  echo
  echo "+ push"
  echo "+ image: dalexandre/syncthing-${ARCH:?}:${VERSION:?}"
  echo

  docker push "dalexandre/syncthing-$ARCH:$VERSION"
  docker push "dalexandre/syncthing-$ARCH:latest"
}

function push-i386 {
	ARCH="i386"

	push
}

function push-x86_64 {
	push-i386
}

push-$ARCH