#!/bin/sh
source ${UTILS_FILE}

function brewif() {
    local package="$1"
    if ! brew ls --versions "$package" >/dev/null; then
        debug "Installing $package..."
        execute brew install $package
    fi
}

if ! command -v brew &>/dev/null; then
    info "Installing homebrew..."
    execute /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

info "Installing zsh..."
brewif zsh

if [ "$SHELL" != "$(brew --prefix)/bin/zsh" ] && [ "$SHELL" != "/bin/zsh" ] ; then
    info "Changing shell to zsh..."
    execute "chsh -s $(which zsh)"
fi

info "Installing fzf..."
brewif fzf
execute $(brew --prefix)/opt/fzf/install --all

info "Installing highlighting for editors..."
brewif --cask nano
brewif nanorc
echo "include $(brew --prefix)/Cellar/nano/*/share/nano/*.nanorc" >>${HOME}/.nanorc

info "Installing productivy-boosting tools..."
brewif python3
brewif fd
brewif btop
brewif ctop
brewif diff-so-fancy
brewif wget
brewif coreutils
brewif navi
brewif bat
brewif ripgrep
brewif tree
brewif exa
brewif antidote
brewif tmux
brewif thefuck
brewif pre-commit

info "Installing common development tools..."
brewif git
brewif gdb --with-python --with-all-targets

info "Installing environment for C++..."
brewif cmake
brewif ninja
brewif llvm@14

info "Installing environment for Python..."
execute python3 -m pip install -r ${ROOT_DIR}/requirements.txt

info "Installing environment for Go..."
brewif go

info "Installing environment for Rust..."
brewif rustup
execute rustup-init -y

info "Installing pyenv..."
brewif pyenv

info "Installing interesting tools for day-to-day use..."
brewif ansiweather
brewif achannarasappa/tap/ticker
brewif ical-buddy

info "Installing fonts for iTerm2..."
brew tap homebrew/cask-fonts
brewif --cask font-meslo-lg-nerd-font

info "Installing antidote..."
brewif antidote