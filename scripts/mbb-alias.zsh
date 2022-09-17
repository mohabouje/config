# Map exa commands to normal ls commands
alias ll="exa -l -g --icons"
alias ls="exa --icons"
alias la="exa --icons -lah"
alias lh="exa --icons -lh"
alias lt="exa --tree --icons -a"

# Other alias replacing default system behavior
alias grep='grep --color=auto'

# Special case for git repositories
alias ls-code=la --git-ignore --ignore-glob=".git"
alias lt-code=lt --git-ignore --ignore-glob=".git"
