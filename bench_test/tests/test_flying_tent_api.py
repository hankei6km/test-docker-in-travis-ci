# -*- coding: utf-8 -*-
#
# Copyright (c) 2018 hankei6km
# Licensed under the MIT License. See LICENSE.txt in the project root.

import pytest
import aiohttp
import asyncio
import async_timeout
# import functools


async def fetch(session, url):
    with async_timeout.timeout(10):
        async with session.get(url) as response:
            return await response.text()


class TestFlyngTentAPI:
    @pytest.mark.asyncio
    async def test_fetch_api(self, api_endpoint, ref_result):

        res = []
        async with aiohttp.ClientSession() as session:
            # Append all responces text into `res` by called back from futures.
            def cb(fut):
                res.append(fut.result())

            # Call some fetch parallel.
            wait = []
            for api_method in ['do-fly', 'dont-fly', 'do-fly', 'dont-fly']:
                fut = asyncio.ensure_future(
                            fetch(session, api_endpoint + '/' + api_method)
                        )
                fut.add_done_callback(cb)
                wait.append(fut)

            # Wait all futures.
            await asyncio.wait(wait)

        # `do-fly` api responced slowly.
        # therfore, serialized to ['dont-fly', 'dont-fly', 'do-fly', 'do-fly']
        assert ref_result == '.'.join(res)
