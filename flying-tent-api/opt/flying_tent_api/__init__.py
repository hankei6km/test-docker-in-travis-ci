# -*- coding: utf-8 -*-
#
# Copyright (c) 2018 hankei6km
# Licensed under the MIT License. See LICENSE.txt in the project root.

import os
import asyncio
from aiohttp import web
from flying_tent.flying_tent import FlyingTent


async def handle_do_fly(request):
    name = request.match_info.get('name', "Anonymous")
    ft = FlyingTent()
    ft.do_fly(True)
    text = await asyncio.sleep(1, result=ft.render())
    return web.Response(text=text)


async def handle_dont_fly(request):
    name = request.match_info.get('name', "Anonymous")
    ft = FlyingTent()
    ft.do_fly(False)
    text = ft.render()
    return web.Response(text=text)


def main():
    if os.getenv("VCAP_APP_PORT"):
        port = int(os.getenv("VCAP_APP_PORT"))
    else:
        port = 8080

    app = web.Application()
    app.router.add_get('/api/do-fly', handle_do_fly)
    app.router.add_get('/api/dont-fly', handle_dont_fly)

    web.run_app(app, host='0.0.0.0', port=port)
