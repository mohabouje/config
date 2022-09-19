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

info "Installing GUI tools for developers..."
brewif --cask nano
brewif --cask qt-creator
brewif --cask tower
brewif --cask clion
brewif --cask pycharm
brewif --cask code
brewif --cask iterm2
brewif --cask docker
brewif --cask wireshark

info "Installing GUI tools for productivity..."
brewif --cask notion
brewif --cask typora

info "Installing GUI tools for communication..."
brewif --cask zoom
brewif --cask microsoft-teams

info "Installing GUI tools for entertainment..."
brewif --cask spotify
brewif --cask whatsapp
brewif --cask discord

info "Installing highlighting for editors..."
brewif nanorc
echo "include $(brew --prefix)/Cellar/nano/*/share/nano/*.nanorc" >>${HOME}/.nanorc

info "Installing common development tools..."
brewif git

# info "Installating valgrind addapted to M1 architecture..."
# brew tap LouisBrunner/valgrind
# brew install --HEAD LouisBrunner/valgrind/valgrind

# info "Installating gdb addapted to M1 architecture..."
# sudo port install gdb-apple
# ln -s $(which gdb-apple) /opt/homebrew/bin/gdb

info "Installing environment for C++..."
brewif cmake
brewif ninja
brewif llvm
brewif ccache
brewif gcc

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

info "Installing seer to use gdb with a nice interface..."
if ! command -v seergdb &>/dev/null; then
    info "Installing seer..."
    brewif qt@5
    export CMAKE_PREFIX_PATH="/opt/homebrew/opt/qt@5:$CMAKE_PREFIX_PATH";
    export PKG_CONFIG_PATH="/opt/homebrew/opt/qt@5/lib/pkgconfig"
    export CPPFLAGS="-I/opt/homebrew/opt/qt@5/include"
    export LDFLAGS="-L/opt/homebrew/opt/qt@5/lib"
    rm -rf ${HOME}/.seer
    git clone https://github.com/epasveer/seer ${HOME}/.seer
    perl -p  -e 'print "cmake_policy(SET CMP0006 OLD)" if $. == 4' ${HOME}/.seer/src/CMakeLists.txt > ${HOME}/.seer/src/CMakeLists.fixed
    mv ${HOME}/.seer/src/CMakeLists.fixed ${HOME}/.seer/src/CMakeLists.txt
    (cd ${HOME}/.seer/src && rm -rf build && mkdir -p build  && cd build && cmake .. -DCMAKE_BUILD_TYPE=Release && make -j10 && sudo make install)
fi