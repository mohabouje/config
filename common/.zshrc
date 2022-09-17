# Fix for oh-my-zsh error:zle:9: widgets can only be called when ZLE is active
TRAPWINCH() {
  zle && { zle reset-prompt; zle -R }
}

# Autoload required plugins to avoid errors on antidote
autoload -U compinit && compinit
autoload -Uz promptinit && promptinit

# Setup of the antidote plugin manager
zstyle ':antidote:bundle' use-friendly-names 'yes'
source ${ANTIDOTE_HOME}/antidote.zsh
antidote bundle < ${HOME}/.antidoterc > ${HOME}/.antidoterc.zsh
source ${HOME}/.antidoterc.zsh
