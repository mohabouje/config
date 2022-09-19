#!/bin/sh
source ${UTILS_FILE}

info "Removing git configuration files..."
delete_file ${HOME}/.gitignore
delete_file ${HOME}/.gitmessage
delete_file ${HOME}/.gitattributes
delete_file ${HOME}/.gitconfig
delete_file ${HOME}/.gitlint
delete_file ${HOME}/.pre-commit-config.yaml

info "Removing installed git hooks..."
delete_folder ${HOME}/.gittemplate
