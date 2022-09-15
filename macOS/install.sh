#!/bin/sh

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
PARENT_DIR="$(dirname "$SCRIPT_DIR")"
COMMON_DIR="$PARENT_DIR/common"

brewif() { if brew ls --versions "$1" &>/dev/null; then : else brew install "$1"; fi; }

echo "Downloading a set of functionalities from GitHub"
curl --silent -L git.io/antigen >${HOME}/.antigen.zsh && chmod +x ${HOME}/.antigen.zsh
curl --silent -L https://raw.githubusercontent.com/beauwilliams/awesome-fzf/master/awesome-fzf.zsh >${HOME}/.awesome-fzf.zsh && chmod +x ${HOME}/.awesome-fzf.zsh
curl --silent -L https://raw.githubusercontent.com/rupa/z/master/z.sh >${HOME}/.zcommand.sh && chmod +x ${HOME}/.zcommand.sh
curl --silent -L https://raw.githubusercontent.com/nikitavoloboev/dotfiles/master/zsh/functions/fzf-functions.zsh >${HOME}/.fzf-functions.zsh && chmod +x ${HOME}/.fzf-functions.zsh

echo "Installing Homebrew..."
if [[ $(command -v brew) == "" ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Installing zsh..."
brewif zsh
chsh -s $(which zsh)

if [ ! -d "$ZSH" ]; then
    echo "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

echo "Installing common configuration files..."
cp -r ${COMMON_DIR}/.zshrc ${HOME}/.zshrc
cp -r ${COMMON_DIR}/.ansiweather ${HOME}/.ansiweather

echo "Installing fzf..."
brewif fzf
/opt/homebrew/opt/fzf/install --all

echo "Installing highlight for nano..."
brewif --cask nano
brewif nanorc
echo 'include "/opt/homebrew/Cellar/nano/*/share/nano/*.nanorc"' >>${HOME}/.nanorc

echo "Installing pre-configured tools..."
brewif fd btop ctop diff-so-fancy wget coreutils navi ansiweather

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

echo 'export AWESOME_FZF_LOCATION=$(which fzf)\n' | cat - ${HOME}/.zshrc >temp && mv temp ${HOME}/.zshrc
echo '# Load path for awesome-fzf' | cat - ${HOME}/.zshrc >temp && mv temp ${HOME}/.zshrc

echo '. ${HOME}/.awesome-fzf.zsh\n' | cat - ${HOME}/.zshrc >temp && mv temp ${HOME}/.zshrc
echo '. ${HOME}/.zcommand.sh' | cat - ${HOME}/.zshrc >temp && mv temp ${HOME}/.zshrc
echo '. ${HOME}/.fzf-functions.zsh' | cat - ${HOME}/.zshrc >temp && mv temp ${HOME}/.zshrc
echo '# Load external functionalities' | cat - ${HOME}/.zshrc >temp && mv temp ${HOME}/.zshrc

echo "export PATH=\"\${HOME}/.git-fuzzy/bin:\$PATH\"\n" | cat - ${HOME}/.zshrc >temp && mv temp ${HOME}/.zshrc
echo "# Load default git-fuzzy binaries" | cat - ${HOME}/.zshrc >temp && mv temp ${HOME}/.zshrc

echo 'export ZPLUG_HOME=/opt/homebrew/opt/zplug\n' | cat - ${HOME}/.zshrc >temp && mv temp ${HOME}/.zshrc
echo "# Exporting zplug home" | cat - ${HOME}/.zshrc >temp && mv temp ${HOME}/.zshrc

echo "Making installed packages available in the terminal..."
echo 'eval $(thefuck --alias)\n' | cat - ${HOME}/.zshrc >temp && mv temp ${HOME}/.zshrc
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' | cat - ${HOME}/.zshrc >temp && mv temp ${HOME}/.zshrc
echo '# Make installed packages available in the terminal' | cat - ${HOME}/.zshrc >temp && mv temp ${HOME}/.zshrc
