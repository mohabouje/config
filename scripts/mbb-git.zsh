# This file contains a set of functions to extend git functionalities with fzf, fd, and other tools
# The file is meant to be sourced in .zshrc or .bashrc.
# This file contains extensions for the following git commands:
# - git status
# - git checkout

__is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

# Enhanced Git Status (Open multiple files with tab + diff preview)
function mbb-git-status() {
    __is_in_git_repo || { echo "This is not a git repository" && return }
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