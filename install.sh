#!/bin/sh
source $(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)/initialize.sh
source ${UTILS_FILE}

info "Installing common configuration files..."
copy_files ${ROOT_DIR}/common ${HOME}

info "Installing common scripts..."
copy_files ${ROOT_DIR}/scripts ${CONFIG_DIR}

sh ${OS_DIR}/install.sh
sh ${GIT_DIR}/install.sh
success "Installation of dependencies completed successfully!"