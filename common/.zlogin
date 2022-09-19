# Source installed scripts, functionalities and aliases
for f in ${CONFIG_DIR}/*.zsh; do chmod +x ${f}; done
for f in ${CONFIG_DIR}/*.zsh; do source ${f}; done

# Export any personal configuration on top of the default configuration
[ -f \${HOME}/.zpersonal ] && \${HOME}/.zpersonal
