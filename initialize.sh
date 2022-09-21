#!/bin/sh
export ROOT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
export CONFIG_DIR="${HOME}/.config/$USER"
export UTILS_FILE=${ROOT_DIR}/utils.sh
source ${UTILS_FILE}

OS="$(uname)"
case $OS in
'Darwin')
    export GIT_DIR=${ROOT_DIR}/git
    export OS_DIR=${ROOT_DIR}/mac
    ;;
*) ;;
esac