#!/bin/bash
#
# flying-tent-api のテストをするスクリプト.
# 当初はこれで済ませようと思っていのたのだが、
# curl を複数並列に実行した結果を安全にまとめる方法がいまいち思いつかなかったので、
# 使うのをやめた(いちおう動いているようには見えるけど、たぶんタイミング依存).
#
# Copyright (c) 2018 hankei6km
# Licensed under the MIT License. See LICENSE.txt in the project root.

set -e

REF="⛺ ⛺ ⛺ 💨⛺ 💨" 

# https://stackoverflow.com/questions/17157721/how-to-get-a-docker-containers-ip-address-from-the-host
FT_ENDPOINT="http://$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' flying-tent-api):8080/api"

TMP_DIR="$(pwd)/tmp"
TMP_FILE="${TMP_DIR}/res.txt"
[ -d "${TMP_DIR}" ] && rm -rf "${TMP_DIR}"
mkdir "${TMP_DIR}"

# redirection atomic?
curl -s "${FT_ENDPOINT}/do-fly" >> "${TMP_FILE}" &
curl -s "${FT_ENDPOINT}/dont-fly" >> "${TMP_FILE}" &
curl -s "${FT_ENDPOINT}/do-fly" >> "${TMP_FILE}" &
curl -s "${FT_ENDPOINT}/dont-fly"  >> "${TMP_FILE}" &

wait

echo "REF: ${REF}"
echo "RES: $(cat $TMP_FILE)"

diff <(echo -n "${REF}") "${TMP_FILE}"
RET="${?}"

rm -rf "$TMP_DIR"

exit "${RET}"
