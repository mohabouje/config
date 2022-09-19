#!/bin/sh
source ${UTILS_FILE}

HOMEBREW_PREFIX=$(brew --prefix)

info "Exporting terminal default environment variables in .zshenv"

append_ln ${HOME}/.zshenv '# Default path for homebrew'
append ${HOME}/.zshenv "export HOMEBREW_PREFIX=${HOMEBREW_PREFIX}"

append_ln ${HOME}/.zshenv '# Environment variables to change $EDITOR and $PAGER'
append ${HOME}/.zshenv 'export EDITOR=${HOMEBREW_PREFIX}/bin/nano'

append_ln ${HOME}/.zshenv '# Environment variables for LLVM'
append ${HOME}/.zshenv 'export PATH="${HOMEBREW_PREFIX}/opt/llvm/bin:$PATH"'

append_ln ${HOME}/.zshenv '# Environment variables for pyenv'
append ${HOME}/.zshenv 'export PYENV_ROOT="$HOME/.pyenv"'

append_ln ${HOME}/.zshenv '# Environment variables for antidote'
append ${HOME}/.zshenv 'export ANTIDOTE_HOME=${HOMEBREW_PREFIX}/opt/antidote/share/antidote'

info "Exporting configuration for interactive shell .zprofile"

append_ln ${HOME}/.zprofile '# Loading required tools for interactive terminal'
append ${HOME}/.zprofile 'eval $(${HOMEBREW_PREFIX}/bin/brew shellenv)'
append ${HOME}/.zprofile 'eval $(${HOMEBREW_PREFIX}/bin/thefuck --alias)'

append_ln ${HOME}/.zprofile '# Loading required steps to run pyenv in an interactive terminal'
append ${HOME}/.zprofile 'export PYENV_ROOT="$HOME/.pyenv"'
append ${HOME}/.zprofile 'export PATH="$PYENV_ROOT/bin:$PATH"'
append ${HOME}/.zprofile 'eval "$(pyenv init --path)"'
append ${HOME}/.zprofile 'eval "$(pyenv init -)"'

info "Exporting configuration for interactive shell .zshrc"

append_ln ${HOME}/.zshrc '# Configuration to enable pyenv interactive shell features'
append ${HOME}/.zshrc 'eval "$(${HOMEBREW_PREFIX}/bin/pyenv init -)"'


info "Installing specific functionalities for macOS"

cat ${OS_DIR}/.zshenv >> ${HOME}/.zshenv
cat ${OS_DIR}/.zlogin >> ${HOME}/.zlogin