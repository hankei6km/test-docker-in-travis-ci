#! /bin/bash
#
# Copyright (c) 2018 hankei6km
# Licensed under the MIT License. See LICENSE.txt in the project root.

set -e

: ${IMAGE_NAME:="hankei6km/test-docker-in-travis-ci"}
: ${IMAGE_TAG:="latest"}
: ${CONTAINER_NAME:="flying-tent-api"}
: ${REF_RESULT:=""}

docker run --rm -d --name "${CONTAINER_NAME}" --hostname "${CONTAINER_NAME}" "${IMAGE_NAME}:${IMAGE_TAG}" /bin/sh -c "cd /opt ; python -m flying_tent_api"
