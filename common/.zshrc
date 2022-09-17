# Fix for oh-my-zsh error:zle:9: widgets can only be called when ZLE is active
TRAPWINCH() {
  zle && { zle reset-prompt; zle -R }
}

# Simple alias for the weather app
alias weather="ansiweather"
weather-in() {
  ansiweather -l "$1"
}

# Source zplug
source ${ZPLUG_HOME}/init.zsh

# Load powerlevel10k theme
zplug "romkatv/powerlevel10k", use:powerlevel10k.zsh-theme

# Standard plugins from oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/autojump", from:oh-my-zsh
zplug "plugins/z", from:oh-my-zsh
zplug "plugins/python", from:oh-my-zsh

# Installing plugins for k
zplug "supercrabtree/k"

# Installing plugins for fzf
zplug "unixorn/fzf-zsh-plugin"

# Highlighting plugins for zsh
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zdharma-continuum/fast-syntax-highlighting"

# Autto-complete and auto-sugesstions made easy for zsh
zplug "marlonrichert/zsh-autocomplete"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo
    zplug install
  fi
fi

# Apply the final changes
zplug load
