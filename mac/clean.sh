#!/bin/sh

# Personal scripts and configuration
rm -rf ${HOME}/.config/mbb

# Common configuration files
rm ${HOME}/.zshrc
rm ${HOME}/.nanorc
rm ${HOME}/.p10k.zsh
rm ${HOME}/.fzf.zsh
rm ${HOME}/.fzf.bash

# Common folders for terminal plugins
rm -rf ${HOME}/.oh-my-zsh
rm -rf ${HOME}/.fzf
rm -rf ${HOME}/.zsh_sessions

# Git configuration files
# rm ${HOME}/.gitconfig
# rm ${HOME}/.gitignore_global
# rm ${HOME}/.gitmessage
# rm ${HOME}/.gitattributes
# rm ${HOME}/.gitconfig

# Third party tools
rm ${HOME}/.ansiweatherrc
rm ${HOME}/.ticker.yaml
