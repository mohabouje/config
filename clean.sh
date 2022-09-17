#!/bin/sh
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

OS="$(uname)"
case $OS in
'Darwin')
    sh ${SCRIPT_DIR}/mac/clean.sh
    ;;
*) ;;
esac
