# -*- coding: utf-8 -*-
#
# Copyright (c) 2018 hankei6km
# Licensed under the MIT License. See LICENSE.txt in the project root.

import os
import pytest


@pytest.fixture
def api_endpoint():
    return 'http://{container_addr}:{container_port}/api'.format(
            container_addr=os.environ.get('CONTAINER_ADDR'),
            container_port=os.environ.get('CONTAINER_PORT', '8080')
            )


@pytest.fixture
def ref_result():
    return os.environ.get('REF_RESULT',  '⛺ .⛺ .⛺ 💨.⛺ 💨')
