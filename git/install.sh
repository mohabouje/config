#!/bin/sh
source ${UTILS_FILE}

if [ -z "$DEFAULT_NAME" ] || [ -z "$DEFAULT_EMAIL" ]; then
    warning "Missing DEFAULT_NAME and DEFAULT_EMAIL in environment"
    DEFAULT_NAME="Mohammed Boujemaoui Boulaghmoudi"
    DEFAULT_EMAIL="mohabouje@gmail.com"
fi

info "Adding a global configuration for git..."
git config --global user.name "${DEFAULT_NAME}"
git config --global user.email "${DEFAULT_EMAIL}"
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

copy_files ${GIT_DIR}/hooks ${HOME}/.gittemplate/hooks
copy_files ${GIT_DIR}/pre-commit ${HOME}/.gittemplate/pre-commit
cp -r ${GIT_DIR}/.[^.]* ${HOME}
