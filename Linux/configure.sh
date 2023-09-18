#!/bin/sh
source ${UTILS_FILE}


info "Exporting terminal default environment variables in .zshenv"

append_ln ${HOME}/.zshenv '# Environment variables to change $EDITOR and $PAGER'
append ${HOME}/.zshenv 'export EDITOR=/usr/bin/nano'

append_ln ${HOME}/.zshenv '# Environment variables for pyenv'
append ${HOME}/.zshenv 'export PYENV_ROOT="$HOME/.pyenv"'

append_ln ${HOME}/.zshenv '# Environment variables for antidote'
append ${HOME}/.zshenv 'export ANTIDOTE_HOME=${HOME}/.antidote'

info "Installing specific functionalities for macOS"

cat ${OS_DIR}/.zshenv >> ${HOME}/.zshenv
cat ${OS_DIR}/.zlogin >> ${HOME}/.zlogin