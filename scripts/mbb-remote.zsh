# This file contains a set of functions that extend the functionality of the terminal.
# The file is meant to be sourced in .zshrc or .bashrc.

# Function to check if host is reachable
function mbb-host-reachable() {
    if [ -z "$1" ]; then
        echo -e "$(__failed) Missing IP/Hostname"
        return 1
    fi
    if ping -c1 -W1 $1 >> /dev/null; then
        echo -e "$(__success)"
    else
        echo -e "$(__failed)"
    fi
}
alias reachable="mbb-host-reachable"

# Function to print all the running ssh sessions
function mbb-ssh-print-sessions() {
    ps -ef | grep ssh | grep -v grep | awk '{print $1 " " $2 " " $8 " " $9 " " $10}'
}
alias ssh-sessions='mbb-ssh-print-sessions'

# Function to print resources on remote host
function mbb-ssh-print-resources() {
    ssh $1 "top -b -n 1 | head -n 10"
}
alias ssh-top='mbb-ssh-print-resources'

# Function to get the current time on remote host
function mbb-ssh-print-time() {
    ssh $1 "date"
}
alias ssh-time='mbb-ssh-print-time'

# Function to print the current user on remote host
function mbb-ssh-print-user() {
    ssh $1 "whoami"
}
alias ssh-user='mbb-ssh-print-user'

# Function to display the current properties of the ssh session
function mbb-ssh-properties() {
    if mbb-shell-check-remote | grep -q "No"; then
        echo "$(colored "No ssh session detected" $TERMINAL_COLOR_RED)"
        return
    fi

    echo "$(colored $TERMINAL_COLOR_GREEN "Session: $(whoami)@$(hostname)")"
    [ -n "$SSH_CLIENT" ] && echo "SSH_CLIENT=$SSH_CLIENT"
    [ -n "$SSH_TTY" ] && echo "SSH_TTY=$SSH_TTY"
    [ -n "$SSH_AUTH_SOCK" ] && echo "SSH_CLIENT=$SSH_AUTH_SOCK"
    [ -n "$SSH_CONNECTION" ] && echo "SSH_CLIENT=$SSH_CONNECTION"
}
alias ssh-properties='mbb-ssh-properties'


