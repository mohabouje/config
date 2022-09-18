#!/bin/sh
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source ${SCRIPT_DIR}/utils.sh

OS="$(uname)"
case $OS in
'Darwin')
    sh ${SCRIPT_DIR}/mac/clean.sh
    sh ${SCRIPT_DIR}/git/clean.sh
    success "Cleanup completed successfully!"
    ;;
*) ;;
esac
