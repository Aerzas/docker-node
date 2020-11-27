#!/bin/sh
set -e

build_version="${1}"
build_node_version="${2}"
if [ -z "${build_version}" ]; then
  echo 'Build version is required' >&2
  exit 1
fi

registry_image='aerzas/node'

node_base_tag() {
  node_version="${1}"
  if [ -z "${node_version}" ]; then
    echo 'Node version is required' >&2
    return 1
  fi

  case ${node_version} in
  10)
    echo node:10.23.0-alpine3.11
    ;;
  12)
    echo node:12.20.0-alpine3.12
    ;;
  14)
    echo node:14.15.1-alpine3.12
    ;;
  *)
    return 0
    ;;
  esac
}

build_base() {
  node_image="${1}"
  node_version="${2}"

  docker build \
    --build-arg BUILD_NODE_IMAGE="${node_image}" \
    -t "${registry_image}:${node_version}-${build_version}" \
    -f base/Dockerfile \
    ./base \
    --no-cache
}

build_dev() {
  node_version="${1}"

  docker build \
    --build-arg BUILD_NODE_IMAGE="${registry_image}:${node_version}-${build_version}" \
    -t "${registry_image}:${node_version}-${build_version}-dev" \
    -f dev/Dockerfile \
    ./dev \
    --no-cache
}

build_node() {
  node_version="${1}"
  if [ -z "${node_version}" ]; then
    echo 'Build Node version is required' >&2
    return 1
  fi
  if [ -z "$(node_base_tag ${node_version})" ]; then
    echo 'Build Node version is invalid' >&2
    return 1
  fi

  echo "$(printf '\033[32m')Build Node images ${node_version}$(printf '\033[m')"

  # Build images
  build_base "$(node_base_tag ${node_version})" "${node_version}"
  build_dev "${node_version}"

  # Push images
  docker push "${registry_image}:${node_version}-${build_version}"
  docker push "${registry_image}:${node_version}-${build_version}-dev"

  # Remove local images
  docker image rm \
    "${registry_image}:${node_version}-${build_version}" \
    "${registry_image}:${node_version}-${build_version}-dev"
}

# Build single Node version
if [ -n "${build_node_version}" ]; then
  build_node "${build_node_version}"
# Build all Node versions
else
  build_node 10
  build_node 12
  build_node 14
fi
