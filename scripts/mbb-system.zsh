# This file contains a set of functions that extend the functionality of the terminal.
# The file is meant to be sourced in .zshrc or .bashrc.

# Function to print the current IP
alias me-ip="echo $(curl -s https://api.ipify.org)"
alias me-hostname="hostname"
alias me-username="whoami"
alias me-time="date"

# Function to print information about current session
function mbb-properties() {
    echo -e "User: $(me-username)"
    echo -e "Hostname: $(me-hostname)"
    echo -e "Time: $(me-time)"
    echo -e "IP: $(me-ip)"
}
alias me-properties='mbb-properties'