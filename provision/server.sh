#!/bin/sh

SINK_FILE_PATH=/etc/hosts
TARGET_STRING="10.0.2.102 k3s-agent k3s-agent"

cat "${SINK_FILE_PATH}" | grep "${TARGET_STRING}" >/dev/null
GREP_RESULT=$?
[ $GREP_RESULT -ne 0 ] && echo "${TARGET_STRING}" >> "${SINK_FILE_PATH}"

curl -sfL https://get.k3s.io | K3S_TOKEN=mysecret sh -s -
