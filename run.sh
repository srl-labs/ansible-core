#!/usr/bin/env bash
# Copyright 2023 Nokia
# Licensed under the BSD 3-Clause License.
# SPDX-License-Identifier: BSD-3-Clause


set -o errexit
set -o pipefail

DEFAULT_DOCKER_IMAGE="ghcr.io/srl-labs/ansible"
DEFAULT_DOCKER_TAG="2.15.4"
DEFAULT_BASE_IMAGE=pypy:3.10-slim

# -----------------------------------------------------------------------------
# Helper functions start with _ and aren't listed in this script's help menu.
# -----------------------------------------------------------------------------

# Change to the tests directory only if we're not already there.
# function _cdTests() {
#   if [ "$(pwd)" != "${TESTS_DIR}" ]; then
#     cd "${TESTS_DIR}"
#   fi
# }



# -----------------------------------------------------------------------------
# Publish functions.
# -----------------------------------------------------------------------------

# python subsctring to use in image url
function extract-version {
  local image=$1
  if [[ $image == *"pypy"* ]]; then
    version=${image#*:}  # remove everything before the colon
    version=${version%-*}  # remove everything after the dash
    echo "pypy${version}"
  elif [[ $image == *"python"* ]]; then
    version=${image#*:}  # remove everything before the colon
    version=${version%-*}  # remove everything after the dash
    echo "py${version}"
  else
    echo "Invalid image format"
  fi
}

function build {
  if [ -z "$1" ]; then
      BASE_IMAGE=${DEFAULT_BASE_IMAGE}
  else
      BASE_IMAGE=$1
  fi

  if [ -z "$2" ]; then
      TAG=${DEFAULT_DOCKER_TAG}
  else
      TAG=$2
  fi

  PY_VERSION_TAG=$(extract-version ${BASE_IMAGE})

  echo ${PY_VERSION_TAG}


  docker build --build-arg BASE_IMAGE=${BASE_IMAGE} -t ${DEFAULT_DOCKER_IMAGE}/${PY_VERSION_TAG}:${TAG} .
}

# testing release-triggered workflow
function test-act-release {
  gh act release -W '.github/workflows/build-release.yml' -e .github/workflows/release-event.json -s GITHUB_TOKEN="$(gh auth token)" --matrix base-image:python:3.10-slim
}

# -----------------------------------------------------------------------------
# Bash runner functions.
# -----------------------------------------------------------------------------
function help {
  printf "%s <task> [args]\n\nTasks:\n" "${0}"

  compgen -A function | grep -v "^_" | cat -n

  printf "\nExtended help:\n  Each task has comments for general usage\n"
}

"${@:-help}"