#!/bin/sh

SINK_FILE_PATH=/etc/hosts
TARGET_STRING="10.0.2.101 k3s-server k3s-server"

cat "${SINK_FILE_PATH}" | grep "${TARGET_STRING}" >/dev/null
GREP_RESULT=$?
[ $GREP_RESULT -ne 0 ] && echo "${TARGET_STRING}" >> "${SINK_FILE_PATH}"

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="agent --server https://10.0.2.101:6443 --node-ip 10.0.2.102 --node-external-ip 10.0.2.102 --token mysecret" sh -
