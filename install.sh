#!/bin/sh
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
CONFIG_FOLDER="${HOME}/.config/.$USER"
source ${SCRIPT_DIR}/utils.sh

OS="$(uname)"
case $OS in
'Darwin')
    GIT_FOLDER=${SCRIPT_DIR}/git
    OS_FOLDER=${SCRIPT_DIR}/mac
    ;;
*) ;;
esac


sh ${OS_FOLDER}/install.sh
sh ${GIT_FOLDER}/install.sh

info "Installing aliases and functions..."
echo '\n# Load extensions and extra functionalities' >> ${HOME}/.zshrc
echo "for f in ${CONFIG_FOLDER}/*.zsh; do source \$f; done\n" >> ${HOME}/.zshrc
success "Setup completed successfully!"