#!/bin/sh

$(brew --prefix)/opt/fzf/uninstall >>/dev/null

# Personal scripts and configuration
rm -rf ${HOME}/.config/mbb

# Common configuration files
[ -f ${HOME}/.zshrc ] && rm ${HOME}/.zshrc
[ -f ${HOME}/.nanorc ] && rm ${HOME}/.nanorc
[ -f ${HOME}/.p10k.zsh ] && rm ${HOME}/.p10k.zsh
[ -f ${HOME}/.fzf.zsh ] && rm ${HOME}/.fzf.zsh
[ -f ${HOME}/.fzf.bash ] && rm ${HOME}/.fzf.bash
[ -f ${HOME}/.zshrc.pre-oh-my-zsh ] && rm ${HOME}/.zshrc.pre-oh-my-zsh

[ -f ${HOME}/.antidoterc ] && rm ${HOME}/.antidoterc
[ -f ${HOME}/.zshrc.pre-oh-my-zsh ] && rm ${HOME}/.antidoterc.zsh

# Common folders for terminal plugins
rm -rf ${HOME}/.oh-my-zsh
rm -rf ${HOME}/.fzf
rm -rf ${HOME}/.zsh_sessions

# Git configuration files
[ -f ${HOME}/.gitignore_global ] && rm ${HOME}/.gitignore_global
[ -f ${HOME}/.gitmessage ] && rm ${HOME}/.gitmessage
[ -f ${HOME}/.gitattributes ] && rm ${HOME}/.gitattributes
rm -rf ${HOME}/.git-template

# Third party tools
[ -f ${HOME}/.ansiweatherrc ] && rm ${HOME}/.ansiweatherrc
[ -f ${HOME}/.ticker.yaml ] && rm ${HOME}/.ticker.yaml
