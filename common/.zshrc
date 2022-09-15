# Aliases for common commands on Linux
alias la='ls -lah --color=auto'
alias lh='ls -lh --color=auto'
alias ls='ls --color=auto'
alias l='ls --color=auto'
alias grep='grep --color=auto'

# Gray color for autosuggestions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=247'

# fzf settings. Uses sharkdp/fd for a faster alternative to `find`.
export FZF_CTRL_T_COMMAND='fd --type f --hidden --exclude .git --exclude .cache'
export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'

# Simple alias for the weather app
alias weather="ansiweather"
weather-in() {
  ansiweather -l "$1"
}

# Simple alias for ticker app
alias calendar-today="icalBuddy eventsToday"
alias calendar-now="icalBuddy eventsNow"
alias calendar-tomorrow="icalBuddy eventsFrom:'tomorrow' to:'tomorrow'"
alias calendar-week="icalBuddy eventsToday+7"
calendar-in() {
  icalBuddy eventsWeek+"$1"
}

# Source zplug
source ${ZPLUG_HOME}/init.zsh

# Load powerlevel10k theme
zplug "romkatv/powerlevel10k", use:powerlevel10k.zsh-theme

# Standard plugins from oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/autojump", from:oh-my-zsh
zplug "plugins/z", from:oh-my-zsh

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
