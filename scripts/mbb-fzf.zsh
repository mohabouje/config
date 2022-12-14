# This file contains my personal configuration for fzf.
# The file is meant to be sourced in .zshrc or .bashrc.
# This file applies different changes to the default behavior of fzf.
# The changes are:
# - Use fd instead of find for a boost in speed
# - Use bat instead of cat for a boost in speed
# - Add options to fzf to ignore .gitingore and .gitignore_global
# - Add options to fzf to ignore .git

export FZF_DEFAULT_COMMAND='fd --color=always --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND} --type f"
export FZF_ALT_C_COMMAND="${FZF_DEFAULT_COMMAND} --type d"

FZF_DEFAULT_OPTS+=' --ansi'
FZF_DEFAULT_OPTS+=' --extended'
FZF_DEFAULT_OPTS+=' --info=inline'
FZF_DEFAULT_OPTS+=' --multi'
FZF_DEFAULT_OPTS+=' --layout reverse'
FZF_DEFAULT_OPTS+=' --border'
FZF_DEFAULT_OPTS+=' --prompt="∼ "'
FZF_DEFAULT_OPTS+=' --pointer="▶"'
FZF_DEFAULT_OPTS+=' --marker="✓"'
FZF_DEFAULT_OPTS+=' --preview="bat --color=always --style=numbers --line-range :500 {}"'
FZF_DEFAULT_OPTS+=' --preview-window=right:hidden:wrap'
FZF_DEFAULT_OPTS+=' --bind "?:toggle-preview"'
FZF_DEFAULT_OPTS+=' --bind "ctrl-a:select-all"'
FZF_DEFAULT_OPTS+=' --bind "ctrl-d:deselect-all"'
FZF_DEFAULT_OPTS+=' --bind "ctrl-t:toggle-all"'
FZF_DEFAULT_OPTS+=' --bind "ctrl-s:toggle-sort"'
FZF_DEFAULT_OPTS+=' --bind "ctrl-r:reload(eval $FZF_DEFAULT_COMMAND)"'
export FZF_DEFAULT_OPTS
