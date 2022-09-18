#!/bin/sh

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
PARENT_DIR="$(dirname "$SCRIPT_DIR")"
MBB_FOLDER="${HOME}/.config/mbb/$(git rev-parse --short HEAD)"

prepend() {
    local file="$1"
    local text="$2"
    local tmpFile="$(mktemp)"
    echo "$text" >"$tmpFile"
    cat "$file" >>"$tmpFile"
    mv "$tmpFile" "$file"
}

brewif() {
    local package="$1"
    if ! brew ls --versions "$package" >/dev/null; then
        brew install "$package"
    fi
}

download() {
    local url="$1"
    local file="$2"
    if [ ! -f "$script" ]; then
        curl -sL "$url" -o "$file"
        chmod +x "$file"
    fi
}

if ! command -v brew &>/dev/null; then
    echo "Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
HOMEBREW_PREFFIX=$(brew --prefix)

echo "Installing zsh..."
brewif zsh

if [ "$SHELL" != "/usr/local/bin/zsh" ] && [ "$SHELL" != "/bin/zsh" ]; then
    echo "Changing shell to zsh..."
    chsh -s /bin/zsh
fi

echo "Installing common configuration files..."
cp -a ${PARENT_DIR}/common/. ${HOME}

echo "Installing common scripts..."
mkdir -p ${MBB_FOLDER}
cp -a ${PARENT_DIR}/scripts/. ${MBB_FOLDER}

echo "Installing fzf..."
brewif fzf
$HOMEBREW_PREFFIX/opt/fzf/install --all >>/dev/null

echo "Installing highlight for editors..."
brewif --cask nano
brewif nanorc
echo "include ${HOMEBREW_PREFFIX}/Cellar/nano/*/share/nano/*.nanorc" >>${HOME}/.nanorc
echo "set rtp+=${HOMEBREW_PREFFIX}/opt/fzf" >>${HOME}/.vimrc

echo "Installing pre-configured tools..."
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
brewif cppcheck

echo "Installing anaconda..."
brewif --cask anaconda
$HOMEBREW_PREFFIX/anaconda3/bin/conda init zsh >>/dev/null

echo "Installing interesting tools for day-to-day use..."
brewif ansiweather
brewif achannarasappa/tap/ticker
brewif ical-buddy

echo "Installing fonts for iTerm2..."
brew tap homebrew/cask-fonts
brewif --cask font-meslo-lg-nerd-font

echo "Installing antidote..."
brewif antidote

echo "Adding configurations to the shell configuration file..."

# This is an script to make sure that pre-commit is always installed in all git repositories
mkdir -p ${HOME}/.git-template/hooks
cp -a ${PARENT_DIR}/git/hooks/. ${HOME}/.git-template/hooks/
cp -a ${PARENT_DIR}/git/. ${HOME}/

prepend ${HOME}/.zshrc "export EDITOR=$(which code)\n"
prepend ${HOME}/.zshrc '# Set the default editor for most operations to code'

prepend ${HOME}/.zshrc "for f in ${MBB_FOLDER}/*.zsh; do source \$f; done\n"
prepend ${HOME}/.zshrc '# Load extensions and extra functionalities'

prepend ${HOME}/.zshrc "export PATH=\"\${HOME}/.git-fuzzy/bin:\$PATH\"\n"
prepend ${HOME}/.zshrc "# Load default git-fuzzy binaries"

prepend ${HOME}/.zshrc 'export ANTIDOTE_HOME=$(brew --prefix)/opt/antidote/share/antidote\n'
prepend ${HOME}/.zshrc "# Exporting antidote home"

prepend ${HOME}/.zshrc 'eval $(thefuck --alias)\n'
prepend ${HOME}/.zshrc 'eval "$(/opt/homebrew/bin/brew shellenv)"'
prepend ${HOME}/.zshrc '# Make installed packages available in the terminal'

echo "\n# macOS configuration\n" >>${HOME}/.zshrc
cat ${SCRIPT_DIR}/.zshrc >>${HOME}/.zshrc
