#!/bin/sh
source ${UTILS_FILE}

info "Removing personal scripts and extra functionalities..."
delete_folder ${CONFIG_DIR}

info "Deleting zsh related configuration files..."
delete_file ${HOME}/.zshrc
delete_file ${HOME}/.zlogin
delete_file ${HOME}/.zlogout
delete_file ${HOME}/.zprofile
delete_file ${HOME}/.zshenv
delete_file ${HOME}/.p10k.zsh
delete_file ${HOME}/.fzf.zsh
delete_file ${HOME}/.fzf.bash
delete_file ${HOME}/.zshrc.pre-oh-my-zsh
delete_file ${HOME}/.antidoterc
delete_file ${HOME}/.antidoterc.zsh
delete_folder ${HOME}/.oh-my-zsh
delete_folder ${HOME}/.fzf
delete_folder ${HOME}/.zsh_sessions

rm ${HOME}/.zshrc.pre-oh-my-zsh* 2>/dev/null

info "Deleting pyenv environments..."
delete_folder $HOME/.pyenv

info "Deleting editor related configuration files..."
delete_file ${HOME}/.vimrc
delete_file ${HOME}/.nanorc

info "Deleting day-to-day tools configuration files..."
delete_file ${HOME}/.ansiweatherrc
delete_file ${HOME}/.ticker.yaml