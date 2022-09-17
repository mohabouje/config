# This file contains a set of functions that extend the functionality of the terminal.
# The file is meant to be sourced in .zshrc or .bashrc.

# Search for an specific alias
function mbb-aliases() {
    CMD=$(
        ( 
            (alias)
        ) | fzf --preview '' | cut -d '=' -f1
    )

    eval $CMD
}
alias falias='mbb-aliases'

# Search for an specific function
function mbb-functions() {
    CMD=$(
        ( 
            (functions | grep "()" | cut -d ' ' -f1 | grep -v "^_")
        ) | fzf --ansi --preview 'which {} | bat' | cut -d '=' -f1
    )

    eval $CMD
}
alias ffunctions='mbb-functions'
