#!/bin/sh

SINK_FILE_PATH=/etc/hosts
TARGET_STRING="10.0.2.101 k3s-server k3s-server"

cat "${SINK_FILE_PATH}" | grep "${TARGET_STRING}" >/dev/null
GREP_RESULT=$?
[ $GREP_RESULT -ne 0 ] && echo "${TARGET_STRING}" >> "${SINK_FILE_PATH}"

curl -sfL https://get.k3s.io | K3S_URL=https://10.0.2.101:6443 K3S_TOKEN=mysecret sh -s -
