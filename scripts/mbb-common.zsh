# This file contains a set of functions that extend the functionality of the terminal.
# The file is meant to be sourced in .zshrc or .bashrc.

# define all color values for terminal printing
export TERMINAL_COLOR_BLACK=30
export TERMINAL_COLOR_RED=31
export TERMINAL_COLOR_GREEN=32
export TERMINAL_COLOR_YELLOW=33
export TERMINAL_COLOR_BLUE=34
export TERMINAL_COLOR_MAGENTA=35
export TERMINAL_COLOR_CYAN=36
export TERMINAL_COLOR_WHITE=37

function colored() {
    echo -e "\033[1;${2}m${1}\033[0m"
}

function __yes() {
    colored "✓ Yes" $TERMINAL_COLOR_GREEN
}

function __no() {
    colored "✗ No" $TERMINAL_COLOR_RED
}

function __success() {
    colored "✓ Success" $TERMINAL_COLOR_GREEN
}

function __failed() {
    colored "✗ Failed" $TERMINAL_COLOR_RED
}

# Quick check of the properties of the current terminal
function mbb-shell-check-option() {
    case $- in
    *$1*)
        echo -e "$(__yes)"
        ;;
    *)
        echo -e "$(__no)"
        ;;
    esac
}

# Check if the current terminal is running in tmux
function mbb-shell-check-tmux() {
    if ! { [ "$TERM" = "screen" ] && [ -n "$TMUX" ]; } then
        echo -e "$(__no)"
    else
        echo -e "$(__yes)"
    fi
}

# Check if the current terminal is running in screen
function mbb-shell-check-screen() {
    if [ "$TERM" = "screen" ]; then
        echo -e "$(__yes)"
    else
        echo -e "$(__no)"
    fi
}

# Check if the current terminal is running in a virtual terminal
function mbb-check-virtual-terminal() {
    if [ -n "$VIRTUAL_TERMINAL" ]; then
        echo -e "$(__yes)"
    else
        echo -e "$(__no)"
    fi
}

# Check if the current terminal is running in an ssh session
function mbb-shell-check-ssh() {
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        echo -e "$(__yes)"
    else
        echo -e "$(__no)"
    fi
}

# Check if the current terminal has an ssh agent
function mbb-shell-check-ssh-agent() {
    if [ -n "$SSH_AUTH_SOCK" ]; then
        echo -e "$(__yes)"
    else
        echo -e "$(__no)"
    fi
}

# Check if the current terminal is running in a docker container
function mbb-shell-check-docker() {
    if [ -f /.dockerenv ]; then
        echo -e "$(__yes)"
    else
        echo -e "$(__no)"
    fi
}

# Check if the current terminal is running in a WSL environment
function mbb-shell-check-wsl() {
    if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null; then
        echo -e "$(__yes)"
    else
        echo -e "$(__no)"
    fi
}

# Function to check if terminal is running remotely
function mbb-shell-check-remote() {
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ] || [ -n "$SSH_AUTH_SOCK" ] || [ -n "$SSH_CONNECTION" ]; then
        echo -e "$(__yes)"
    else
        echo -e "$(__no)"
    fi
}

function mbb-shell-properties() {
    echo "Shell: $SHELL ($0)"
    echo "Interactive: $(mbb-shell-check-option i)"
    echo "Restricted: $(mbb-shell-check-option r)"
    echo "Login: $(mbb-shell-check-option l)"
    echo "SSH-Agent: $(mbb-shell-check-ssh-agent)"
    echo "SSH-Session: $(mbb-shell-check-ssh)"
    echo "Tmux: $(mbb-shell-check-tmux)"
    echo "Screen: $(mbb-shell-check-screen)"
    echo "Docker: $(mbb-shell-check-docker)"
    echo "WSL: $(mbb-shell-check-wsl)"
    echo "Virtual Terminal: $(mbb-check-virtual-terminal)"
}
alias shell-properties='mbb-shell-properties'

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
