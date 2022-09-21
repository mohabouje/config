# Source installed scripts, functionalities and aliases
for f in ${HOME}/.config/$USER/*.zsh; do chmod +x ${f}; done
for f in ${HOME}/.config/$USER/*.zsh; do source ${f}; done

# Export any personal configuration on top of the default configuration
[ -f \${HOME}/.zpersonal ] && \${HOME}/.zpersonal
