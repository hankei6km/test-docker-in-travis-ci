# test-docker-in-travis-ci

[Using Docker in Builds - Travis CI](https://docs.travis-ci.com/user/docker/)
を参考に、
Travis CI で Docker コンテナを使ってみるテストのリポジトリ.


## 概要

### flying-tent-api

[hankei6km/test-travis-ci](https://github.com/hankei6km/test-travis-ci)の `flying_tent` パッケージを流用した API サーバー的なコンテナイメージ(を作成するための Dockerfile と、[python:3-alpine](https://hub.docker.com/_/python/)と[aiohttp](https://aiohttp.readthedocs.io/en/stable/) によるサーバースクリプト).
イメージは Docker HUB 上に作成される.


## License

Copyright (c) 2018 hankei6km

Licensed under the MIT License. See LICENSE.txt in the project root.

