#!/bin/sh

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
PARENT_DIR="$(dirname "$SCRIPT_DIR")"
source ${PARENT_DIR}/utils.sh

echo "Removing personal scripts and extra functionalities..."
delete_folder ${HOME}/.config/mbb

echo "Deleting zsh related configuration files..."
delete_file ${HOME}/.zshrc
delete_file ${HOME}/.p10k.zsh
delete_file ${HOME}/.fzf.zsh
delete_file ${HOME}/.fzf.bash
delete_file ${HOME}/.zshrc.pre-oh-my-zsh
delete_file ${HOME}/.antidoterc
delete_file ${HOME}/.antidoterc.zsh
delete_folder ${HOME}/.oh-my-zsh
delete_folder ${HOME}/.fzf
delete_folder ${HOME}/.zsh_sessions

echo "Deleting editor related configuration files..."
delete_file ${HOME}/.vimrc
delete_file ${HOME}/.nanorc

echo "Deleting day-to-day tools configuration files..."
delete_file ${HOME}/.ansiweatherrc
delete_file ${HOME}/.ticker.yaml
