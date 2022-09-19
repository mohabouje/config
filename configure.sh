#!/bin/sh
source $(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)/initialize.sh
source ${UTILS_FILE}

sh ${OS_DIR}/configure.sh
success "Configuration completed successfully!"