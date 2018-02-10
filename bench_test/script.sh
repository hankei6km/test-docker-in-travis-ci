#! /bin/bash
#
# Copyright (c) 2018 hankei6km
# Licensed under the MIT License. See LICENSE.txt in the project root.

set -e

. ./bench_test/set_env.sh

# https://stackoverflow.com/questions/17157721/how-to-get-a-docker-containers-ip-address-from-the-host
export CONTAINER_ADDR="$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ${CONTAINER_NAME})"

# "${HOME}/.local/bin/pytest"
pytest
