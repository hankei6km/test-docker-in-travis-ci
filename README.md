# test-docker-in-travis-ci

[![Build Status](https://travis-ci.org/hankei6km/test-docker-in-travis-ci.svg?branch=master)](https://travis-ci.org/hankei6km/test-docker-in-travis-ci)

[Using Docker in Builds - Travis CI](https://docs.travis-ci.com/user/docker/)
を参考に、
Travis CI で Docker コンテナを使ってみるテストのリポジトリ.


## 概要

### コンテナイメージ

[`flying-tent-api/`](https://github.com/hankei6km/test-docker-in-travis-ci/tree/master/flying-tent-api)

[hankei6km/test-travis-ci](https://github.com/hankei6km/test-travis-ci)の `flying_tent` パッケージを流用した API サーバー的なコンテナイメージ(を作成するための Dockerfile と、[python:3-alpine](https://hub.docker.com/_/python/)と[aiohttp](https://aiohttp.readthedocs.io/en/stable/) によるサーバースクリプト).
Docker HUB 上に[hankei6km/test-docker-in-travis-ci](https://hub.docker.com/r/hankei6km/test-docker-in-travis-ci/)として登録してある.

### テスト

[`bench_test`](https://github.com/hankei6km/test-docker-in-travis-ci/tree/master/bench_test)

上記のコンテナを起動し、API のテストを実行.

#### スクリプト

以下をそれぞれ
`.travis.yml` の `before_install:` と `script:` に設定することでテストが実行される.

* `bench_test/before_isntall.sh`: コンテナを起動.
* `bench_test/script.sh`: テストを実行.


#### 環境変数

* `IMAGE_NAME`: コンテナのイメージ名.
* `IMAGE_TAG`: イメージのタグ.
* `CONTAINER_NAME`: 実行するコンテナに付ける名前.
* `REF_RESULT`: API からの戻り値と比較する文字列(テストを失敗させるため等に利用).


## 考慮点と今後の課題

思っていたよりも躓くことなく Docker コンテナを利用したテストを実行できたのだが、いくつか考慮すべき点も出てきた.

たとえば、
現状の構成では GitHub へプッシュした時点で Docker HUB と Travis CI 上でのビルドが発動されてしまう.
このため、Docker HUB 上でのビルドが完了するのを待たずに Travis CI 側でジョブが走ってしまい、
最新のコンテナイメージでのテストが実行された状態にはならない
(PULL されたイメージの ID をきちんと確認はしていないが、
実行状況をブラウザて見ていた限りで待っているようには見えなかった)、
ということが挙げられる.

これについては、

* 設定等でトリガーの連鎖を制御する.
* コンテナイメージとテストのリポジトリを分ける.
* docker build を Travis CI 側で実行する.

等が考えられるが、
そもそもが「コンテナをテストしたい」のか「コンテナでテストしたい」のか等
によっても解が変わってくると思われる.

この辺のリポジトリの構成や自動化のフローについては、
「ちょっとためしてみようかな」という範疇を超えるので、
今後の課題ということにしたい.


## License

Copyright (c) 2018 hankei6km

Licensed under the MIT License. See LICENSE.txt in the project root.

