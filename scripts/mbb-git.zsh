# This file contains a set of functions to extend git functionalities with fzf, fd, and other tools
# The file is meant to be sourced in .zshrc or .bashrc.
# This file contains extensions for the following git commands:
# - git status
# - git checkout

function __is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

function __is_editor_set() {
    if [ -z "$EDITOR" ]; then
        return 1
    fi
    return 0
}

# Enhanced Git Status (Open multiple files with tab + diff preview)
function mbb-git-status() {
    __is_in_git_repo || { echo "This is not a git repository" && return }
    __is_editor_set || { echo "\code is not defined" && return }
    local selected
    selected=$(git -c color.status=always status --short |
        fzf --height 50% "$@" --border -m --ansi --nth 2..,.. \
        --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
        cut -c4- | sed 's/.* -> //')
            if [[ $selected ]]; then
                for prog in $(echo $selected);
                do; $EDITOR $prog; done;
            fi
}
alias gstatus='mbb-git-status'

# Checkout to existing branch or else create new branch
# Falls back to fuzzy branch selector list powered by fzf if no args.
function mbb-git-checkout(){
    __is_in_git_repo || { echo "This is not a git repository" && return }
    __is_editor_set || { echo "\code is not defined" && return }
    if [[ "$#" -eq 0 ]]; then
        local branches branch
        branches=$(git branch -a) &&
        branch=$(echo "$branches" |
        fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
        git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
    elif [ `git rev-parse --verify --quiet $*` ] || \
            [ `git branch --remotes | grep  --extended-regexp "^[[:space:]]+origin/${*}$"` ]; then
        echo "Checking out branch $*"
        git checkout "$*"
    else
        echo "Creating a new branch $*"
        git checkout -b "$*"
    fi
}
alias gcheckout='mbb-git-checkout'

# Create a function to git commit with fzf
function mbb-git-commit() {
    __is_in_git_repo || { echo "This is not a git repository" && return }
    __is_editor_set || { echo "\code is not defined" && return }
    local selected
    selected=$(git status --short |
        fzf --height 50% "$@" --border -m --ansi --nth 2..,.. \
        --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
        cut -c4- | sed 's/.* -> //')
            if [[ $selected ]]; then
                for prog in $(echo $selected);
                do; git add $prog; done;
            fi
    git commit
}
alias gcommit='mbb-git-commit'

# Custom key-binding to keep consistency cross platforms
export GIT_FUZZY_SELECT_ALL_KEY="Ctrl-A"
export GIT_FUZZY_SELECT_NONE_KEY="Ctrl-D"
export GIT_FUZZY_STATUS_ADD_KEY='Ctrl-O'
export GIT_FUZZY_STATUS_RESET_KEY='Ctrl-R'
export GIT_FUZZY_STATUS_EDIT_KEY='Ctrl-E'
export GIT_FUZZY_STATUS_COMMIT_KEY='Space'
export GIT_FUZZY_STATUS_DISCARD_KEY='Ctrl-X'

alias gf-commit=git-fuzzy status
alias gf-log=git-fuzzy log
alias gf-diff=git-fuzzy diff
alias gf-branch=git-fuzzy branch
