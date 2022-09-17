# This file contains a set of functions that extends a set of common unix commands with fzf, fd, regrep and other tools.
# The file is meant to be sourced in .zshrc or .bashrc.
# The file contains extensions for the following commands:
# - rm
# - man
# - eval
# - open/xdg-open
# - cd
# - find [find directory, find file, find parent]
# - env
# - kill

# Extention of rm command
function mbb-rm() {
  if [[ "$#" -eq 0 ]]; then
    local files
    files=$(find . -maxdepth 1 -type f | fzf --multi)
    echo $files | xargs -I '{}' rm {}
  else
    command rm "$@"
  fi
}
alias frm='mbb-rm'

# Extention of man command
function mbb-man() {
	if [ -n "$1" ]; then
		man "$@"
		return $?
	else
		man -k . | fzf --reverse --preview="echo {1,2} | sed 's/ (/./' | sed -E 's/\)\s*$//' | xargs man" | awk '{print $1 "." $2}' | tr -d '()' | xargs -r man
		return $?
	fi
}
alias fman='mbb-man'

# Extension to eval commands on the fly
function mbb-eval() {
  echo | fzf -q "$*" --preview-window=up:99% --preview="eval {q}"
}
alias feval='mbb-eval'

# Search for a file and open it with the system default application
function mbb-open-files() {
  local file=$(fzf --multi --reverse)
  if [[ $file ]]; then
    case `uname` in
    Darwin)
      for prog in $(echo $file);
      do; open $prog; done;
    ;;
    *)
      for prog in $(echo $file);
      do; xdg-open $prog; done;
    ;;
    esac
  else
    :
  fi
}
alias fopen='mbb-open-files'

# Search for an specific directory and jump to it
function mbb-cd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf --extended --ansi --preview 'ls {} | bat' +m) &&
  cd "$dir"
}
alias fcd='mbb-cd'
alias fdir='mbb-cd'

# Search for an specific directory and jump to it (including hidden directories)
function mbb-cd-incl-hidden() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf --extended --ansi --preview 'ls {} | bat' +m) && cd "$dir"
}
alias fcdh='mbb-cd-incl-hidden'
alias fdirh='mbb-cd-incl-hidden'

# Search for an specific file and jump to it's directory
function mbb-cd-to-file() {
    local file
    local dir
    file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}
alias ffile='mbb-cd-to-file'

# Search for an specific parent of the current directory and jump to it
function fzf-cd-to-parent() {
    local declare dirs=()
    get_parent_dirs() {
        if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
        if [[ "${1}" == '/' ]]; then
            for _dir in "${dirs[@]}"; do echo $_dir; done
        else
            get_parent_dirs $(dirname "$1")
        fi
    }
    local DIR=$(get_parent_dirs $(realpath "${1:-$PWD}") | fzf --preview 'ls {} | bat')
    cd "$DIR"
}
alias fparent='fzf-cd-to-parent'

# Search for environment variables
function mbb-env-vars() {
  local out
  out=$(env | fzf --preview '' )
  echo $(echo $out | cut -d= -f2)
}
alias fenv='mbb-env-vars'

# Search for an specfic running process and kill it
function mbb-kill-processes() {
  local pid
  pid=$(ps -ef | sed 1d | fzf --preview '' -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}
alias fkill='mbb-kill-processes'

# Grep for a string in a file
function fzf-grep() {
  local file=$(grep -r --color=always "$1" . | fzf --multi --reverse | awk -F: '{print $1}')
  if [[ $file ]]; then
    for prog in $(echo $file);
    do; echo "$prog"; done;
  else
    :
  fi
}
alias fgrep='fzf-grep'
