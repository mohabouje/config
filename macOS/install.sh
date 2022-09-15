#!/bin/sh

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
PARENT_DIR="$(dirname "$SCRIPT_DIR")"
COMMON_DIR="$PARENT_DIR/common"

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

echo "Downloading a set of functionalities from GitHub"
download git.io/antigen ${HOME}/.antigen.zsh
download https://raw.githubusercontent.com/beauwilliams/awesome-fzf/master/awesome-fzf.zsh ${HOME}/.awesome-fzf.zsh
download https://raw.githubusercontent.com/rupa/z/master/z.sh ${HOME}/.zcommand.sh
download https://raw.githubusercontent.com/nikitavoloboev/dotfiles/master/zsh/functions/fzf-functions.zsh ${HOME}/.fzf-functions.zsh

if ! command -v brew &>/dev/null; then
    echo "Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Installing zsh..."
brewif zsh

if [ "$SHELL" != "/bin/zsh" ]; then
    echo "Changing shell to zsh..."
    chsh -s /bin/zsh
fi

ZSH="${ZSH:-$HOME/.oh-my-zsh}"
if [ ! -d "$ZSH" ]; then
    echo "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

echo "Installing common configuration files..."
cp -r ${COMMON_DIR}/.zshrc ${HOME}
cp -r ${COMMON_DIR}/.ansiweather ${HOME}
cp -r ${COMMON_DIR}/.ticker.yaml ${HOME}

echo "Installing fzf..."
brewif fzf
/opt/homebrew/opt/fzf/install --all

echo "Installing highlight for nano..."
brewif --cask nano
brewif nanorc
echo 'include "/opt/homebrew/Cellar/nano/*/share/nano/*.nanorc"' >>${HOME}/.nanorc

echo "Installing pre-configured tools..."
brewif fd
brewif btop
brewif ctop
brewif diff-so-fancy
brewif wget
brewif coreutils
brewif navi

echo "Installing interesting tools for day-to-day use..."
brewif ansiweather
brewif achannarasappa/tap/ticker
brewif ical-buddy

echo "Installing fonts for iTerm2..."
brew tap homebrew/cask-fonts
brewif --cask font-meslo-lg-nerd-font

echo "Installing git-fuzzy..."
GIT_FUZZY_FOLDER="${HOME}/.git-fuzzy"
if [ ! -d ${GIT_FUZZY_FOLDER} ]; then
    git clone https://github.com/bigH/git-fuzzy.git ${GIT_FUZZY_FOLDER}
fi

echo "Installing zplug..."
brewif zplug

echo "Adding configurations to the shell configuration file..."

prepend ${HOME}/.zshrc 'export AWESOME_FZF_LOCATION=$(which fzf)\n'
prepend ${HOME}/.zshrc '# Load path for awesome-fzf'

prepend ${HOME}/.zshrc '. ${HOME}/.awesome-fzf.zsh\n'
prepend ${HOME}/.zshrc '. ${HOME}/.zcommand.sh'
prepend ${HOME}/.zshrc '. ${HOME}/.fzf-functions.zsh'
prepend ${HOME}/.zshrc '# Load external functionalities'

prepend ${HOME}/.zshrc "export PATH=\"\${HOME}/.git-fuzzy/bin:\$PATH\"\n"
prepend ${HOME}/.zshrc "# Load default git-fuzzy binaries"

prepend ${HOME}/.zshrc 'export ZPLUG_HOME=/opt/homebrew/opt/zplug\n'
prepend ${HOME}/.zshrc "# Exporting zplug home"

prepend ${HOME}/.zshrc 'eval $(thefuck --alias)\n'
prepend ${HOME}/.zshrc 'eval "$(/opt/homebrew/bin/brew shellenv)"'
prepend ${HOME}/.zshrc '# Make installed packages available in the terminal'
