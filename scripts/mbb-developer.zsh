# This file contains a set of functions that simplify some of the actions that I do as developer on a daily basis.
# The file is meant to be sourced in .zshrc or .bashrc.

# Search for a file and open it with code
function mbb-open-editor() {
  local file=$(fzf --multi --reverse)
  if [[ $file ]]; then
    for prog in $(echo $file);
    do; code $prog; done;
  else
    :
  fi
}
alias ocode='mbb-open-editor'

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
alias gcode='mbb-grep-code'