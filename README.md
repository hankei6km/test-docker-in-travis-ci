# test-docker-in-travis-ci

[Using Docker in Builds - Travis CI](https://docs.travis-ci.com/user/docker/)
を参考に、
Travis CI で Docker コンテナを使ってみるテストのリポジトリ.


## 概要

### flying-tent-api

[hankei6km/test-travis-ci](https://github.com/hankei6km/test-travis-ci)の `flying_tent` パッケージを流用した API サーバー的なコンテナイメージ(を作成するための Dockerfile と、[python:3-alpine](https://hub.docker.com/_/python/)と[aiohttp](https://aiohttp.readthedocs.io/en/stable/) によるサーバースクリプト).
Docker HUB 上に[hankei6km/test-docker-in-travis-ci](https://hub.docker.com/r/hankei6km/test-docker-in-travis-ci/)として登録してある.

### bench\_test

上記のコンテナを起動し、API のテストを実行.


環境変数
* `IMAGE_NAME`: コンテナのイメージ名.
* `IMAGE_TAG`: イメージのタグ.
* `CONTAINER_NAME`: 実行するコンテナに付ける名前.
* `REF_RESULT`: API からの戻り値と比較する文字列(テストを失敗させるため等に利用).


## License

Copyright (c) 2018 hankei6km

Licensed under the MIT License. See LICENSE.txt in the project root.

