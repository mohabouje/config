#!/bin/sh

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
PARENT_DIR="$(dirname "$SCRIPT_DIR")"
CONFIG_FOLDER="${HOME}/.config/.$USER"
source ${PARENT_DIR}/utils.sh

function brewif() {
    local package="$1"
    if ! brew ls --versions "$package" >/dev/null; then
        debug "Installing $package..."
        brew install "$package"
    fi
}

if ! command -v brew &>/dev/null; then
    echo "Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
HOMEBREW_PREFFIX=$(brew --prefix)

info "Installing zsh..."
brewif zsh

if [ "$SHELL" != "/usr/local/bin/zsh" ] && [ "$SHELL" != "/bin/zsh" ]; then
    echo "Changing shell to zsh..."
    chsh -s /bin/zsh
fi

info "Installing common configuration files..."
copy_files ${PARENT_DIR}/common ${HOME}

info "Installing common scripts..."
copy_files ${PARENT_DIR}/scripts ${CONFIG_FOLDER}

info "Installing fzf..."
brewif fzf
$HOMEBREW_PREFFIX/opt/fzf/install --all >>/dev/null

info "Installing highlight for editors..."
brewif --cask nano
brewif nanorc
echo "include ${HOMEBREW_PREFFIX}/Cellar/nano/*/share/nano/*.nanorc" >>${HOME}/.nanorc
echo "set rtp+=${HOMEBREW_PREFFIX}/opt/fzf" >>${HOME}/.vimrc

info "Installing pre-configured tools..."
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

info "Installing anaconda..."
brewif --cask anaconda
$HOMEBREW_PREFFIX/anaconda3/bin/conda init zsh >>/dev/null

info "Installing interesting tools for day-to-day use..."
brewif ansiweather
brewif achannarasappa/tap/ticker
brewif ical-buddy

info "Installing fonts for iTerm2..."
brew tap homebrew/cask-fonts
brewif --cask font-meslo-lg-nerd-font

info "Installing antidote..."
brewif antidote

info "Adding configurations to the shell configuration file..."
prepend ${HOME}/.zshrc "export EDITOR=$(which nano)\n"
prepend ${HOME}/.zshrc '# Set the default editor for most operations in terminal to nano'

prepend ${HOME}/.zshrc "export PATH=\"\${HOME}/.git-fuzzy/bin:\$PATH\"\n"
prepend ${HOME}/.zshrc "# Load default git-fuzzy binaries"

prepend ${HOME}/.zshrc 'export ANTIDOTE_HOME=$(brew --prefix)/opt/antidote/share/antidote\n'
prepend ${HOME}/.zshrc "# Exporting antidote home"

prepend ${HOME}/.zshrc 'eval $(thefuck --alias)\n'
prepend ${HOME}/.zshrc 'eval "$(/opt/homebrew/bin/brew shellenv)"'
prepend ${HOME}/.zshrc '# Make installed packages available in the terminal'

echo "\n# macOS configuration\n" >>${HOME}/.zshrc
cat ${SCRIPT_DIR}/.zshrc >>${HOME}/.zshrc