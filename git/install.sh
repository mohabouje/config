#!/bin/sh

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
PARENT_DIR="$(dirname "$SCRIPT_DIR")"
PRE_COMMIT_DIR="${HOME}/.config/.$USER/pre-commit"
source ${PARENT_DIR}/utils.sh

if [ -z "$MBB_DEFAULT_NAME" ] || [ -z "$MBB_DEFAULT_EMAIL" ]; then
    warn "Missing MBB_DEFAULT_NAME and MBB_DEFAULT_EMAIL in environment"
    MBB_DEFAULT_NAME="Mohammed Boujemaoui Boulaghmoudi"
    MBB_DEFAULT_EMAIL="mohabouje@gmail.com"
fi

info "Adding a global configuration for git..."
git config --global user.name "${MBB_DEFAULT_NAME}"
git config --global user.email "${MBB_DEFAULT_EMAIL}"
git config --global init.defaultBranch "main"

# Global gitignore, gitattributes and hooks
git config --global init.templateDir "${HOME}/.gittemplate"
git config --global commit.template "${HOME}/.gitmessage"
git config --global core.excludesfile "${HOME}/.gitignore"

# Using nano and diff-so-fancy by default
git config --global core.editor $(which nano)
git config --global core.pager "$(which diff-so-fancy) | less --tabs=4 -RFX"
git config --global pager.show "$(which diff-so-fancy) | less --tabs=1,5 -RFX"
git config --global color.ui true

# Configuration of terminal colors for git-diff
git config --global color.diff.meta "yellow bold"
git config --global color.diff.commit "green bold"
git config --global color.diff.frag "magenta bold"
git config --global color.diff.old "red bold"
git config --global color.diff.new "green bold"
git config --global color.diff.whitespace "red reverse"
git config --global color.diff-highlight.oldNormal "red bold"
git config --global color.diff-highlight.oldHighlight "red bold 52"
git config --global color.diff-highlight.newNormal "green bold"
git config --global color.diff-highlight.newHighlight "green bold 22"

copy_files ${SCRIPT_DIR}/hooks ${HOME}/.gittemplate/hooks
copy_files ${SCRIPT_DIR}/pre-commit ${PRE_COMMIT_DIR}
copy_files ${SCRIPT_DIR} ${HOME}
