# This file contains a set of functions that simplify some of the actions that I do as developer on a daily basis.
# The file is meant to be sourced in .zshrc or .bashrc.

# Search for a file and open it with code
function mbb-open-editor() {
  FD_COMMAND="fd --color=always --strip-cwd-prefix --hidden --follow --exclude .git --type f"
  local file=$(FZF_DEFAULT_COMMAND="${FD_COMMAND}" fzf --multi --reverse --preview-window=right:hidden:wrap)
  if [[ $file ]]; then
    for prog in $(echo $file);
    do; code $prog; done;
  else
    :
  fi
}
alias open-code='mbb-open-editor'

# Grep for a string in a file and open it with code
function mbb-grep-code() {
  SCRIPT_PARENT=${${(%):-%x}:A:h}
  if [ -n "$1" ]; then
		$SCRIPT_PARENT/internal/mbb-ripgrep.sh "$@"
		return $?
	else
    $SCRIPT_PARENT/internal/mbb-ripgrep.sh
    return $?
  fi 
}
alias grep-code='mbb-grep-code'

alias debugger-start='seergdb --start'        # Debug myprog with its arguments. Break in main(). Ex: prog arg1 arg2
alias debugger-run='seergdb --run'            # Debug myprog with its arguments. Run it immediately without breaking. Ex: prog arg1 arg2 
alias debugger-connect='seergdb --connect'    # Debug myprog by connecting to the currently started gdbserver process. Ex: <host:port> prog
alias debugger='seergdb'                      # Bring up a dialog box to set the program and debug method.


function mbb-debugger-attach() {
  local pid
  pid=$(ps -ef | sed 1d | fzf --preview '' -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    seergdb --attach $pid $1
  fi
}
alias debugger-attach='mbb-debugger-attach'


function mbb-debugger-codedump() {
  FD_COMMAND="fd --color=always --strip-cwd-prefix --hidden --follow --exclude .git --type f"
  local file=$(FZF_DEFAULT_COMMAND="${FD_COMMAND}" fzf --multi --reverse)
  if [[ $file ]]; then
    for prog in $(echo $file);
    do; seergdb --core $prog $1; done;
  else
    :
  fi
}
alias debugger-coredump='mbb-debugger-codedump'